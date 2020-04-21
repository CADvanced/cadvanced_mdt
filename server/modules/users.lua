local user_helpers = module("server/modules/helpers/users")
local queries = module("server/modules/queries")
local api = module("server/modules/comms/api")
local client_sender = module("server/modules/comms/client_sender")
local conf = module("server/modules/config")

local users = {}

-- Get the table of whitelisted users
function users.get_whitelisted()
    if conf.val("enable_whitelist") then
        local q_whitelisted = queries.get_whitelisted()
        api.request(
            q_whitelisted,
            function(response)
                if response.error == nil then
                    local whitelist = {}
                    for _, wl in ipairs(response.result.data.allWhitelisted) do
                        table.insert(whitelist, wl.steamId)
                    end
                    state_set("whitelist", whitelist)
                else
                    print_debug(response.error)
                end
            end
        )
    else
        return {}
    end
end

-- Get the table of user ranks
function users.get_all_user_ranks(pass_to_client)
    local q_get_all_user_ranks = queries.get_all_user_ranks()
    api.request(
        q_get_all_user_ranks,
        function(response)
            if response.error == nil then
                local user_ranks = {}
                for _, rank in ipairs(response.result.data.allUserRanks) do
                    table.insert(user_ranks, rank)
                end
                state_set("user_ranks", user_ranks)
                if (pass_to_client ~= nil and pass_to_client) then
                    client_sender.pass_data(state.user_ranks, "user_ranks")
                end
            else
                print_debug(response.error)
            end
        end
    )
end

-- Repopulate all user_ranks
function users.repopulate_user_ranks()
    users.get_all_user_ranks(true)
end

-- Check if a user has a SteamID
function users.validate(source, setKickReason)
    if not source then
        setKickReason(
            "Unable to find SteamID, please relaunch FiveM with steam open or restart FiveM & Steam if steam is already open"
        )
        CancelEvent()
        print_debug("PLAYER JOIN DENIED - NO SOURCE")
        return false
    end
    local id = user_helpers.get_steam_id(source)
    if not id then
        setKickReason(
            "Unable to find SteamID, please relaunch FiveM with steam open or restart FiveM & Steam if steam is already open"
        )
        CancelEvent()
        print_debug("PLAYER JOIN DENIED - NO STEAM ID")
        return false
    end
    if conf.val("enable_whitelist") and not hasValue(state_get("whitelist"), id) then
        setKickReason("You are not whitelisted for this server")
        CancelEvent()
        print_debug("PLAYER JOIN DENIED - NOT WHITELISTED")
        return false
    end
    print_debug("PLAYER JOIN ACCEPTED")
    return true
end

-- Update a players location or add a new one
function users.update_location(source, data)
    local steam_id = user_helpers.get_steam_id(source)
    local user_locations = state_get("user_locations")
    local found = false
    for i, it in ipairs(user_locations) do
        if it.steamId == steam_id then
            user_locations[i] = {
                steamId = steam_id,
                x = data.x,
                y = data.y,
                updated = os.time()
            }
            found = true
            break
        end
    end
    if found == false then
        table.insert(user_locations, {
            steamId = steam_id,
            x = data.x,
            y = data.y,
            updated = os.time()
        })
    end
    state_set("user_locations", user_locations)
end

-- Return all users with locations
function users.get_locations()
    return state_get("user_locations")
end

-- Get a players details and update state as appropriate
function users.populate_player(steamId)
    local is_new = false
    local my_source
    if not steamId then
        is_new = true
        print_debug("GETTING NEWLY CONNECTED PLAYER DETAILS FOR " .. source)
        my_source = source
        steamId = user_helpers.get_steam_id(source)
    else
        print_debug("GETTING UPDATED PLAYER DETAILS FOR " .. steamId)
    end
    local q_user = queries.get_user(steamId)
    api.request(
        q_user,
        function(response)
            if response.error == nil then
                local usr = state_get("users")
                local returned_user = response.result.data.getUser
                if returned_user ~= nil then
                    if is_new then
                        returned_user.source = my_source
                        table.insert(usr, returned_user)
                    else
                        for i, it in ipairs(usr) do
                            if it.steamId == steamId then
                                -- Preserve the user's source
                                returned_user.source = usr[i].source
                                usr[i] = returned_user
                                break
                            end
                        end
                    end
                    state_set("users", usr)
                    -- Send client the updated user list
                    print_debug("SENDING ALL CLIENTS UPDATED USERS")
                    client_sender.pass_data(usr, "users")
                else
                    print_debug("PLAYER " .. steamId .. " NOT FOUND IN CAD")
                    return
                end
            else
                print_debug(response.error)
            end
        end
    )
end

-- Player connect handler
function users.handler_playerConnecting()
    -- Validate a user when they connect
    AddEventHandler(
        "playerConnecting",
        function(name, setKickReason)
            print_debug("PLAYER CONNECTED " .. source)
            print_debug("VALIDATING PLAYER")
            users.validate(source, setKickReason)
        end
    )
end

-- Player dropped handler
---- Remove the user table from state.users
function users.handler_playerDropped()
    AddEventHandler(
        "playerDropped",
        function()
            local id = user_helpers.get_steam_id(source)
            print_debug("PLAYER " .. id .. " DROPPED")
            -- Remove the player from the players table
            local usr = state_get("users")
            for i, user in ipairs(usr) do
                print_debug("USER'S STEAM ID " .. user.steamId .. " - ITERATED ID " .. id)
                if user.steamId == id then
                    table.remove(usr, i)
                    state_set("users", usr)
                    -- Send client the updated user list
                    print_debug("SENDING ALL CLIENTS UPDATED USERS")
                    client_sender.pass_data(usr, "users")
                    break
                end
            end
            -- Remove the player from the active player locations
            local user_locations = state_get("user_locations")
            local filtered = {}
            for i, user_location in ipairs(user_locations) do
                if user_location.steamId == id then
                    print_debug("REMOVING LOCATION FOR PLAYER " .. id)
                else
                    table.insert(filtered, user_location)
                end
            end
            state_set("user_locations", filtered)
        end
    )
end

-- Send the API current user assignments
function users.update_user_units(user_id)
    local user_units = state_get("user_units")
    local user_units_send = {}
    -- Only include this user's assignments
    for i, uu in ipairs(user_units) do
        if (uu.UserId == user_id) then
            table.insert(user_units_send, uu)
        end
    end
    local payload = { user_units = user_units_send, user_id = user_id }
    local q_update_user_units = queries.update_user_units(payload)
    -- This request will prompt the API to notify us of the change, so
    -- we can mostly ignore the response
    api.request(
        q_update_user_units,
        function(response)
            if response.error ~= nil then
                print_debug(response.error)
            end
        end
    )
end

-- Remove a user from a unit in our local state
function users.remove_from_unit(data)
    local user_id = data.userId
    local unit_id = data.unitId
    if (user_id ~= nil and unit_id ~= nil) then
        -- First remove the user from the unit in our local state
        -- we should then have something we can send to the API
        local assignments = state_get("user_units")
        local found = 0
        for i, assignment in ipairs(assignments) do
            if assignment.UserId == user_id and assignment.UnitId == unit_id then
                found = i
            end
        end
        if found > 0 then
            table.remove(assignments, found)
            state_set("user_units", assignments)
            users.update_user_units(user_id)
        else
            print_debug("UNABLE TO FIND SUPPLIED UNIT ASSIGNMENT")
        end
    end
end

-- Add a user to a unit in our local state
function users.add_to_unit(data)
    local user_id = data.userId
    local unit_id = data.unitId
    local rank_id = data.rankId
    if (user_id ~= nil and unit_id ~= nil and rank_id ~= nil) then
        -- First add the user to the unit in our local state
        -- we should then have something we can send to the API
        local assignments = state_get("user_units")
        local found = 0
        for i, assignment in ipairs(assignments) do
            if assignment.UserId == user_id and assignment.UnitId == unit_id and assignment.UserRankId == rank_id then
                found = i
            end
        end
        if found == 0 then
            table.insert(assignments, {
                UserId = user_id,
                UnitId = unit_id,
                UserRankId = rank_id
            })
            state_set("user_units", assignments)
            users.update_user_units(user_id)
        else
            print_debug("UNABLE TO FIND SUPPLIED UNIT ASSIGNMENT")
        end
    end
end

return users
