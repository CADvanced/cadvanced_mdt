local conf = module("server/modules/config")
local user_helpers = module("server/modules/helpers/users")
local citizens = module("server/modules/citizens")
local users = module("server/modules/users")
local units = module("server/modules/units")
local vehicles = module("server/modules/vehicles")
local legal = module("server/modules/legal")
local calls = module("server/modules/calls")
local bolos = module("server/modules/bolos")
local departments = module("server/modules/departments")
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
                cad_url = conf.val("cad_url"),
                homepage = conf.val("homepage"),
                sound_volume = conf.val("sound_volume"),
                debug = conf.val("debug"),
                panic_command = conf.val("panic_command"),
                panic_keybind = conf.val("panic_keybind"),
                panic_flash_mdt = conf.val("panic_flash_mdt"),
                panic_play_tone = conf.val("panic_play_tone"),
                panic_create_marker = conf.val("panic_create_marker"),
                panic_duration = conf.val("panic_duration"),
                terminal_open_command = conf.val("terminal_open_command"),
                terminal_open_keybind_first = conf.val("terminal_open_keybind_first"),
                terminal_open_keybind_second = conf.val("terminal_open_keybind_second"),
                terminal_close_command = conf.val("terminal_close_command"),
                terminal_close_keybind_first = conf.val("terminal_close_keybind_first"),
                terminal_close_keybind_second = conf.val("terminal_close_keybind_second"),
                terminal_move_command = conf.val("terminal_move_command"),
                terminal_move_keybind_first = conf.val("terminal_move_keybind_first"),
                terminal_move_keybind_second = conf.val("terminal_move_keybind_second"),
                call_command = conf.val("call_command"),
                call_keybind_first = conf.val("call_keybind_first"),
                call_keybind_second = conf.val("call_keybind_second"),
                call_number = conf.val("call_number"),
                call_ring_filename = conf.val("call_ring_filename"),
                call_busy_filename = conf.val("call_busy_filename"),
                self_dispatch = conf.val("self_dispatch"),
                disable_busy_tone = conf.val("disable_busy_tone")
            }, "config", source)
            client_sender.pass_data(state_get("calls"), "calls", source)
            client_sender.pass_data(state_get("units"), "units", source)
            client_sender.pass_data(state_get("unit_states"), "unit_states", source)
            client_sender.pass_data(state_get("unit_types"), "unit_types", source)
            client_sender.pass_data(state_get("user_units"), "user_units", source)
            client_sender.pass_data(state_get("user_ranks"), "user_ranks", source)
            client_sender.pass_data(state_get("citizen_markers"), "citizen_markers", source)
            client_sender.pass_data(state_get("vehicle_markers"), "vehicle_markers", source)
            client_sender.pass_data(state_get("vehicle_models"), "vehicle_models", source)
            client_sender.pass_data(state_get("charges"), "charges", source)
            client_sender.pass_data(state_get("locations"), "locations", source)
            client_sender.pass_data(state_get("bolos"), "bolos", source)
            client_sender.pass_data(state_get("call_grades"), "call_grades", source)
            client_sender.pass_data(state_get("call_types"), "call_types", source)
            client_sender.pass_data(state_get("call_incidents"), "call_incidents", source)
            client_sender.pass_data(state_get("departments"), "departments", source)
            client_sender.pass_data(state_get("department_announcements"), "department_announcements", source)
            client_sender.pass_data(user_helpers.get_steam_id(source), "steam_id", source)
        end
    )

    -- Open the MDT
    RegisterNetEvent("open_mdt")
    AddEventHandler(
        "open_mdt",
        function()
            print_debug("RECEIVED REQUEST FROM CLIENT TO OPEN MDT FOR USER " .. source)
            if (hasOfficer(source)) then
                client_sender.pass_data(nil, "open_mdt", source)
            else
                client_sender.pass_data("Only an officer can do this", "send_chat", source)
            end
        end
    )

    -- Open the terminal
    RegisterNetEvent("open_terminal")
    AddEventHandler(
        "open_terminal",
        function()
            print_debug("RECEIVED REQUEST FROM CLIENT TO OPEN TERMINAL FOR USER " .. source)
            if (hasOfficer(source)) then
                client_sender.pass_data(nil, "open_terminal", source)
            else
                client_sender.pass_data("Only an officer can do this", "send_chat", source)
            end
        end
    )

    -- Close the terminal
    RegisterNetEvent("close_terminal")
    AddEventHandler(
        "close_terminal",
        function()
            print_debug("RECEIVED REQUEST FROM CLIENT TO CLOSE TERMINAL FOR USER " .. source)
            if (hasOfficer(source)) then
                client_sender.pass_data(nil, "close_terminal", source)
            else
                client_sender.pass_data("Only an officer can do this", "send_chat", source)
            end
        end
    )

    -- Toggle the terminal draggable state
    RegisterNetEvent("terminal_drag_toggle")
    AddEventHandler(
        "terminal_drag_toggle",
        function()
            print_debug("RECEIVED REQUEST FROM CLIENT TO TOGGLE THE TERMINAL DRAG STATE FOR USER " .. source)
            if (hasOfficer(source)) then
                client_sender.pass_data(nil, "terminal_drag_toggle", source)
            else
                client_sender.pass_data("Only an officer can do this", "send_chat", source)
            end
        end
    )

    -- Open the call
    RegisterNetEvent("open_call")
    AddEventHandler(
        "open_call",
        function()
            print_debug("RECEIVED REQUEST FROM CLIENT TO OPEN CALL FOR USER " .. source)
            if (not conf.val('call_require_citizen') or hasCitizen(source)) then
                client_sender.pass_data(nil, "open_call", source)
            else
                client_sender.pass_data("Only a citizen can do this", "send_chat", source)
            end
        end
    )

    -- Start panic
    RegisterNetEvent("start_panic")
    AddEventHandler(
        "start_panic",
        function()
            print_debug("RECEIVED REQUEST FROM CLIENT TO START PANIC FOR USER " .. source)
            if (hasOfficer(source)) then
                users.start_panic()
            else
                client_sender.pass_data("Only an officer can do this", "send_chat", source)
            end
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

    -- Perform citizen call creation
    RegisterNetEvent("citizen_call")
    AddEventHandler(
        "citizen_call",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO SEND CITIZEN CALL")
            if (not conf.val('call_require_citizen') or hasCitizen(source)) then
                citizens.send_call(data, client_sender.pass_data, source)
            else
                client_sender.pass_data("Only a citizen can do this", "send_chat", source)
            end
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

    -- Send an offence's metadata
    RegisterNetEvent("send_offence_metadata")
    AddEventHandler(
        "send_offence_metadata",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO SEND OFFENCE METADATA")
            legal.send_offence_metadata(data)
        end
    )

    -- Send a call
    RegisterNetEvent("send_call")
    AddEventHandler(
        "send_call",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO SEND CALL")
            calls.send_call(data)
        end
    )

    -- Send a BOLO
    RegisterNetEvent("send_bolo")
    AddEventHandler(
        "send_bolo",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO SEND BOLO")
            bolos.send_bolo(data)
        end
    )

    -- Delete a call
    RegisterNetEvent("delete_call")
    AddEventHandler(
        "delete_call",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO DELETE CALL")
            calls.delete_call(data)
        end
    )

    -- Delete a BOLO
    RegisterNetEvent("delete_bolo")
    AddEventHandler(
        "delete_bolo",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO DELETE BOLO")
            bolos.delete_bolo(data)
        end
    )

    -- Get a department's announcements
    RegisterNetEvent("get_department_announcements")
    AddEventHandler(
        "get_department_announcements",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO GET DEPARTMENT ANNOUNCEMENTS")
            departments.get_department_announcements(data)
        end
    )

    -- Send a unit
    RegisterNetEvent("send_unit")
    AddEventHandler(
        "send_unit",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO SEND UNIT")
            units.send_unit(data)
        end
    )

    -- Delete a unit
    RegisterNetEvent("delete_unit")
    AddEventHandler(
        "delete_unit",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO DELETE UNIT")
            units.delete_unit(data)
        end
    )

    -- Save a ticket
    RegisterNetEvent("save_ticket")
    AddEventHandler(
        "save_ticket",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO SAVE A TICKET")
            legal.save_ticket(data)
        end
    )

    -- Save an arrest
    RegisterNetEvent("save_arrest")
    AddEventHandler(
        "save_arrest",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO SAVE AN ARREST")
            legal.save_arrest(data)
        end
    )

    -- Delete an offence
    RegisterNetEvent("delete_offence")
    AddEventHandler(
        "delete_offence",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO DELETE OFFENCE")
            legal.delete_offence(data)
        end
    )
    -- Delete a call
    RegisterNetEvent("toggle_assignment")
    AddEventHandler(
        "toggle_assignment",
        function(data)
            print_debug("RECEIVED REQUEST FROM CLIENT TO TOGGLE UNIT ASSIGNMENT")
            calls.toggle_assignment(data)
        end
    )


end

return client_receiver
