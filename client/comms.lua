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
        local command_source = jsonData.source
        local users = state_get("users")
        local hasOfficer = false
        for i, iter in ipairs(users) do
            if (
                command_source == iter.source and
                iter.character and
                iter.character.__typename == "Officer"
            ) then
                hasOfficer = true
                break
            end
        end
        if (hasOfficer) then
            SendNUIMessage({action = "showMdt"})
            SetNuiFocus(true, true)
        else
            TriggerEvent('chat:addMessage', {
                color = { 255, 0, 0},
                multiline = true,
                args = {"MDT", "Only users with an active officer can open the MDT"}
            })
        end
    end
)

RegisterNetEvent("data:config")
AddEventHandler(
    "data:config",
    function(jsonData)
        print_debug("RECEIVED CONFIG FROM SERVER")
        state_set("config", jsonData)
        pass_to_nui(jsonData, "config")
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
