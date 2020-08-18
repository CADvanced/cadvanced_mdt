-- Blindly receive data and pass it to NUI
function pass_to_nui(data, object)
    print_debug("SENDING " .. object .. " TO NUI")
    SendNUIMessage(
        {
            object = object,
            data = data
        }
    )
end

RegisterNetEvent("data:open_mdt")
AddEventHandler(
    "data:open_mdt",
    function(jsonData)
        print_debug("RECEIVED REQUEST FROM SERVER TO OPEN MDT")
        SendNUIMessage({action = "showMdt"})
        SetNuiFocus(true, true)
    end
)

RegisterNetEvent("data:open_terminal")
AddEventHandler(
    "data:open_terminal",
    function(jsonData)
        state_set("terminal_dragging", "no")
        print_debug("RECEIVED REQUEST FROM SERVER TO OPEN TERMINAL")
        SendNUIMessage({action = "openTerminal"})
    end
)

RegisterNetEvent("data:close_terminal")
AddEventHandler(
    "data:close_terminal",
    function(jsonData)
        print_debug("RECEIVED REQUEST FROM SERVER TO CLOSE TERMINAL")
        SendNUIMessage({action = "closeTerminal"})
        SetNuiFocus(false, false)
    end
)

RegisterNetEvent("data:terminal_drag_toggle")
AddEventHandler(
    "data:terminal_drag_toggle",
    function(newState)
        print_debug("RECEIVED REQUEST FROM SERVER TO TOGGLE TERMINAL DRAGGING")
        local current_state = state_get("terminal_dragging")
        if current_state == "yes" then
            SendNUIMessage({action = "terminalDraggingOff"})
            SetNuiFocus(false, false)
            state_set("terminal_dragging", "no")
        else
            SendNUIMessage({action = "openTerminal"})
            SendNUIMessage({action = "terminalDraggingOn"})
            SetNuiFocus(true, true)
            state_set("terminal_dragging", "yes")
        end
    end
)

RegisterNetEvent("data:send_chat")
AddEventHandler(
    "data:send_chat",
    function(message)
        print_debug("RECEIVED REQUEST FROM SERVER TO SEND A CHAT MESSAGE: " .. message)
        sendChat(message)
    end
)

RegisterNetEvent("data:config")
AddEventHandler(
    "data:config",
    function(jsonData)
        print_debug("RECEIVED CONFIG FROM SERVER")
        state_set("config", jsonData)
        pass_to_nui(jsonData, "config")
        -- Register stuff that is dependent on the state
        --
        -- Start a panic
        -- Command
        RegisterCommand(
            state.config.panic_command,
            function(source)
                TriggerServerEvent("start_panic")
            end,
            false -- Allow anyone to issue this command
        )
        -- Keybind
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
                if IsControlJustReleased(0,  tonumber(state.config.panic_keybind)) then
                    TriggerServerEvent("start_panic")
                end
            end
        end)
        -- Open the terminal
        -- Command
        RegisterCommand(
            state.config.terminal_open_command,
            function(source)
                TriggerServerEvent("open_terminal")
            end,
            false -- Allow anyone to issue this command
        )
        -- Keybind
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
                if state.config.terminal_open_keybind_first ~= nil then
                    if IsControlPressed(1, tonumber(state.config.terminal_open_keybind_first)) and IsControlJustReleased(1, tonumber(state.config.terminal_open_keybind_second)) then
                        TriggerServerEvent("open_terminal")
                    end
                else
                    if IsControlJustReleased(1, tonumber(state.config.terminal_open_keybind_second)) then
                        TriggerServerEvent("open_terminal")
                    end
                end
            end
        end)
        -- Close the terminal
        -- Command
        RegisterCommand(
            state.config.terminal_close_command,
            function(source)
                TriggerServerEvent("close_terminal")
            end,
            false -- Allow anyone to issue this command
        )
        -- Keybind
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
                if state.config.terminal_close_keybind_first ~= nil then
                    if IsControlPressed(1, tonumber(state.config.terminal_close_keybind_first)) and IsControlJustReleased(1, tonumber(state.config.terminal_close_keybind_second)) then
                        TriggerServerEvent("close_terminal")
                    end
                else
                    if IsControlJustReleased(1, tonumber(state.config.terminal_close_keybind_second)) then
                        TriggerServerEvent("close_terminal")
                    end
                end
            end
        end)
        -- Allow the terminal to be moved
        -- Command
        RegisterCommand(
            state.config.terminal_move_command,
            function(source)
                TriggerServerEvent("terminal_drag_toggle")
            end,
            false -- Allow anyone to issue this command
        )
        -- Keybind
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
                if state.config.terminal_move_keybind_first ~= nil then
                    if IsControlPressed(1, tonumber(state.config.terminal_move_keybind_first)) and IsControlJustReleased(1, tonumber(state.config.terminal_move_keybind_second)) then
                        TriggerServerEvent("terminal_drag_toggle")
                    end
                else
                    if IsControlJustReleased(1, tonumber(state.config.terminal_move_keybind_second)) then
                        TriggerServerEvent("terminal_drag_toggle")
                    end
                end
            end
        end)
    end
)

RegisterNetEvent("data:units")
AddEventHandler(
    "data:units",
    function(jsonData)
        print_debug("RECEIVED UNITS FROM SERVER")
        pass_to_nui(jsonData, "units")
    end
)

RegisterNetEvent("data:unit_states")
AddEventHandler(
    "data:unit_states",
    function(jsonData)
        print_debug("RECEIVED UNIT STATES FROM SERVER")
        pass_to_nui(jsonData, "unit_states")
    end
)

RegisterNetEvent("data:citizen_markers")
AddEventHandler(
    "data:citizen_markers",
    function(jsonData)
        print_debug("RECEIVED CITIZEN MARKERS FROM SERVER")
        pass_to_nui(jsonData, "citizen_markers")
    end
)

RegisterNetEvent("data:vehicle_markers")
AddEventHandler(
    "data:vehicle_markers",
    function(jsonData)
        print_debug("RECEIVED VEHICLE MARKERS FROM SERVER")
        pass_to_nui(jsonData, "vehicle_markers")
    end
)

RegisterNetEvent("data:charges")
AddEventHandler(
    "data:charges",
    function(jsonData)
        print_debug("RECEIVED CHARGES FROM SERVER")
        pass_to_nui(jsonData, "charges")
    end
)

RegisterNetEvent("data:vehicle_models")
AddEventHandler(
    "data:vehicle_models",
    function(jsonData)
        print_debug("RECEIVED VEHICLE MODELS FROM SERVER")
        pass_to_nui(jsonData, "vehicle_models")
    end
)

RegisterNetEvent("data:calls")
AddEventHandler(
    "data:calls",
    function(jsonData)
        print_debug("RECEIVED CALLS FROM SERVER")
        pass_to_nui(jsonData, "calls")
    end
)

RegisterNetEvent("data:users")
AddEventHandler(
    "data:users",
    function(jsonData)
        print_debug("RECEIVED USERS FROM SERVER")
        state_set("users", jsonData)
        pass_to_nui(jsonData, "users")
    end
)

RegisterNetEvent("data:user_units")
AddEventHandler(
    "data:user_units",
    function(jsonData)
        print_debug("RECEIVED USER_UNITS FROM SERVER")
        pass_to_nui(jsonData, "user_units")
    end
)

RegisterNetEvent("data:user_ranks")
AddEventHandler(
    "data:user_ranks",
    function(jsonData)
        print_debug("RECEIVED USER_RANKS FROM SERVER")
        pass_to_nui(jsonData, "user_ranks")
    end
)

RegisterNetEvent("data:steam_id")
AddEventHandler(
    "data:steam_id",
    function(jsonData)
        print_debug("RECEIVED STEAM ID FROM SERVER")
        pass_to_nui(jsonData, "steam_id")
    end
)

RegisterNetEvent("data:citizen_search_results")
AddEventHandler(
    "data:citizen_search_results",
    function(jsonData)
        print_debug("RECEIVED CITIZEN SEARCH RESULTS FROM SERVER")
        pass_to_nui(jsonData, "citizen_search_results")
    end
)

RegisterNetEvent("data:citizen")
AddEventHandler(
    "data:citizen",
    function(jsonData)
        print_debug("RECEIVED CITIZEN FROM SERVER")
        pass_to_nui(jsonData, "citizen")
    end
)

RegisterNetEvent("data:vehicle_search_results")
AddEventHandler(
    "data:vehicle_search_results",
    function(jsonData)
        print_debug("RECEIVED VEHICLE SEARCH RESULTS FROM SERVER")
        pass_to_nui(jsonData, "vehicle_search_results")
    end
)

RegisterNetEvent("data:citizen_offences")
AddEventHandler(
    "data:citizen_offences",
    function(stringTxt)
        print_debug("RECEIVED CITIZEN OFFENCES FROM SERVER")
        pass_to_nui(stringTxt, "citizen_offences")
    end
)

RegisterNetEvent("data:display_panic")
AddEventHandler(
    "data:display_panic",
    function(jsonData)
        print_debug("RECEIVED PANIC NOTIFICATION FROM SERVER")
        pass_to_nui(jsonData, "display_panic")
    end
)