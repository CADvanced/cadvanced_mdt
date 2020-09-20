local user_helpers = module("server/modules/helpers/users")
local queries = module("server/modules/queries")
local client_sender = module("server/modules/comms/client_sender")
local api = module("server/modules/comms/api")

local citizens = {}

function citizens.send_call(call, callback, src)
    call.steamId = user_helpers.get_steam_id(source)
    local q_send_call = queries.send_citizen_call(call)
    api.request(
        q_send_call,
        function(response)
        end
    )
end

function citizens.search_citizens(search, callback, src)
    local q_search_citizens = queries.search_citizens(search)
    api.request(
        q_search_citizens,
        function(response)
            response = json.decode(response)
            if response.error == nil then
                local received = response.data.searchCitizens
                -- Send client the search results
                print_debug("SENDING ALL CLIENTS CITIZEN SEARCH RESULTS")
                callback(received, "citizen_search_results", src)
            else
                print_debug(response.error)
            end
        end
    )
end

function citizens.get_citizen_offences(data, callback)
    local q_get_citizen_offences = queries.get_citizen_offences(data)
    api.request(
        q_get_citizen_offences,
        function(response)
            local decoded = json.decode(response)
            if decoded.error == nil then
                local received = response
                -- Send client the offences
                print_debug("SENDING ALL CLIENTS CITIZEN OFFENCES")
                callback(received, "citizen_offences")
            else
                print_debug(decoded.error)
            end
        end
    )
end

-- Get the table of citizen markers
function citizens.get_all_markers(pass_to_client)
    local q_get_all_citizen_markers = queries.get_all_citizen_markers()
    api.request(
        q_get_all_citizen_markers,
        function(response)
            response = json.decode(response)
            if response.error == nil then
                local citizen_markers = {}
                for _, marker in ipairs(response.data.allCitizenMarkers) do
                    table.insert(citizen_markers, marker)
                end
                state_set("citizen_markers", citizen_markers)
                if (pass_to_client ~= nil and pass_to_client) then
                    client_sender.pass_data(state.citizen_markers, "citizen_markers")
                end
            else
                print_debug(response.error)
            end
        end
    )
end

-- Update a citizen
function citizens.update_citizen(id)
    local q_get_citizen = queries.get_citizen(id)
    print_debug("UPDATING CITIZEN " .. id)
    api.request(
        q_get_citizen,
        function(response)
            response = json.decode(response)
            if response.error == nil then
                print_debug("PARSING UPDATED CITIZEN")
                local received = response.data.getCitizen
                local ex_citizens = state_get("citizens")
                local found = false
                for i, iter in ipairs(ex_citizens) do
                    if (iter.id == received.id) then
                        ex_citizens[i] = received
                        found = true
                    end
                end
                if not found then
                    table.insert(ex_citizens, received)
                end
                state_set("citizens", ex_citizens)
                -- Send client the updated citizen
                print_debug("SENDING ALL CLIENTS UPDATED CITIZEN")
                client_sender.pass_data(received, "citizen")
            else
                print_debug(response.error)
            end
        end
    )
end

-- Repopulate all vehicle_markers
function citizens.repopulate_citizen_markers()
    citizens.get_all_markers(true)
end

-- Add a marker to a citizen
function citizens.add_marker(data)
    local q_attach_marker_to_citizen = queries.attach_marker_to_citizen(data)
    api.request(
        q_attach_marker_to_citizen,
        function(response)
            response = json.decode(response)
            if response.error ~= nil then
                print_debug(response.error)
            end
        end
    )
end

-- Remove a marker from a citizen
function citizens.remove_marker(data)
    local q_detach_marker_from_citizen = queries.detach_marker_from_citizen(data)
    api.request(
        q_detach_marker_from_citizen,
        function(response)
            response = json.decode(response)
            if response.error ~= nil then
                print_debug(response.error)
            end
        end
    )
end

return citizens