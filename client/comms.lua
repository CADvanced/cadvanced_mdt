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
        RegisterCommand(
            state.config.panic_command,
            function(source)
                TriggerServerEvent("start_panic")
            end,
            false -- Allow anyone to issue this command
        )
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
                if IsControlJustReleased(0,  tonumber(state.config.panic_keybind)) then
                    TriggerServerEvent("start_panic")
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
    function(jsonData)
        print_debug("RECEIVED CITIZEN OFFENCES FROM SERVER")
        pass_to_nui(jsonData, "citizen_offences")
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