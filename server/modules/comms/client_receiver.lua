local conf = module("server/modules/config")
local user_helpers = module("server/modules/helpers/users")
local citizens = module("server/modules/citizens")
local users = module("server/modules/users")
local units = module("server/modules/units")
local vehicles = module("server/modules/vehicles")
local client_sender = module("server/modules/comms/client_sender")

local client_receiver = {}

function client_receiver.client_event_handlers()
    -- Incoming events from client

    -- Send initialisation data
    RegisterNetEvent("send_init")
    AddEventHandler(
        "send_init",
        function()
            print_debug("RECEIVED REQUEST FROM CLIENT FOR INIT DATA")
            -- We call populate_player here rather than just passing the current
            -- state of all users because we probably don't know anything about
            -- this player, so we want to get their data first, which will have
            -- the side effect of distributing it to all clients, including us
            users.populate_player()
            client_sender.pass_data({
                homepage = conf.val("homepage"),
                sound_volume = conf.val("sound_volume"),
                debug = conf.val("debug")
            }, "config", source)
            client_sender.pass_data(state_get("calls"), "calls", source)
            client_sender.pass_data(state_get("units"), "units", source)
            client_sender.pass_data(state_get("unit_states"), "unit_states", source)
            client_sender.pass_data(state_get("user_units"), "user_units", source)
            client_sender.pass_data(state_get("user_ranks"), "user_ranks", source)
            client_sender.pass_data(state_get("citizen_markers"), "citizen_markers", source)
            client_sender.pass_data(state_get("vehicle_markers"), "vehicle_markers", source)
            client_sender.pass_data(state_get("vehicle_models"), "vehicle_models", source)
            client_sender.pass_data(user_helpers.get_steam_id(source), "steam_id", source)
        end
    )

    -- Open the MDT
    RegisterNetEvent("open_mdt")
    AddEventHandler(
        "open_mdt",
        function()
            print_debug("RECEIVED REQUEST FROM CLIENT TO OPEN MDT FOR USER " .. source)
            client_sender.pass_data({ source = source }, "open_mdt", source)
        end
    )

    -- Update player location
    RegisterNetEvent("update_location")
    AddEventHandler(
        "update_location",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO UPDATE LOCATION FOR USER " .. source)
            users.update_location(source, data)
        end
    )

    -- Perform citizen search
    RegisterNetEvent("search_citizens")
    AddEventHandler(
        "search_citizens",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO SEND CITIZEN SEARCH")
            citizens.search_citizens(data, client_sender.pass_data, source)
        end
    )

    -- Perform vehicle search
    RegisterNetEvent("search_vehicles")
    AddEventHandler(
        "search_vehicles",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO SEND VEHICLE SEARCH")
            vehicles.search_vehicles(data, client_sender.pass_data, source)
        end
    )

    -- Get citizen offences
    RegisterNetEvent("get_citizen_offences")
    AddEventHandler(
        "get_citizen_offences",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO GET CITIZEN OFFENCES")
            citizens.get_citizen_offences(data, client_sender.pass_data)
        end
    )

    -- Remove user from unit
    RegisterNetEvent("remove_user_from_unit")
    AddEventHandler(
        "remove_user_from_unit",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO REMOVE USER FROM UNIT")
            users.remove_from_unit(data)
        end
    )

    -- Add user to unit
    RegisterNetEvent("add_user_to_unit")
    AddEventHandler(
        "add_user_to_unit",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO ADD USER TO UNIT")
            users.add_to_unit(data)
        end
    )

    -- Set a unit state
    RegisterNetEvent("set_unit_state")
    AddEventHandler(
        "set_unit_state",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO SET UNIT STATE")
            units.set_unit_state(data)
        end
    )

    -- Add a marker to something
    RegisterNetEvent("add_marker")
    AddEventHandler(
        "add_marker",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO SET ADD MARKER TO " .. data.type)
            if (data.type == 'Citizen') then
                citizens.add_marker(data)
            elseif (data.type == 'Vehicle') then
                vehicles.add_marker(data)
            end
        end
    )

    -- Remove marker from something
    RegisterNetEvent("remove_marker")
    AddEventHandler(
        "remove_marker",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO SET REMOVE MARKER FROM " .. data.type)
            if (data.type == 'Citizen') then
                citizens.remove_marker(data)
            elseif (data.type == 'Vehicle') then
                vehicles.remove_marker(data)
            end
        end
    )
end

return client_receiver