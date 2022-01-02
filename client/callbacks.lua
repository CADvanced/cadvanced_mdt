-- Callback for hiding the MDT
RegisterNUICallback(
    "hideMdt",
    function(_, cb)
        print_debug("RECEIVED hideMdt FROM NUI")
        SetNuiFocus(false, false)
        if cb then
            cb()
        end
    end
)

-- Callback for hiding the call
RegisterNUICallback(
    "hideCall",
    function(_, cb)
        print_debug("RECEIVED hideCall FROM NUI")
        SetNuiFocus(false, false)
        if cb then
            cb()
        end
    end
)

-- Callback for starting a panic
RegisterNUICallback(
    "startPanic",
    function(_, cb)
        -- Tell the server to start the panic
        print_debug("RECEIVED REQUEST FROM NUI TO START PANIC")
        TriggerServerEvent("start_panic")
        if cb then
            cb()
        end
    end
)

-- Callback for sending initialisation data
RegisterNUICallback(
    "init",
    function(_, cb)
        -- Tell the server to send the init data
        print_debug("RECEIVED REQUEST FROM NUI TO SEND INIT DATA")
        print_debug("REQUESTING INIT DATA FROM SERVER")
        TriggerServerEvent("send_init")
        if cb then
            cb()
        end
    end
)

-- Callback to handle citizen searches
RegisterNUICallback(
    "searchCitizen",
    function(data, cb)
        -- Tell the server to send the init data
        print_debug("RECEIVED REQUEST FROM NUI TO SEND CITIZEN SEARCH PARAMETERS")
        print_debug("SENDING CITIZEN SEARCH OBJECT TO SERVER")
        TriggerServerEvent("search_citizens", data)
        if cb then
            cb()
        end
    end
)

-- Callback to handle vehicle searches
RegisterNUICallback(
    "searchVehicle",
    function(data, cb)
        -- Tell the server to send the init data
        print_debug("RECEIVED REQUEST FROM NUI TO SEND VEHICLE SEARCH PARAMETERS")
        print_debug("SENDING VEHICLE SEARCH OBJECT TO SERVER")
        TriggerServerEvent("search_vehicles", data)
        if cb then
            cb()
        end
    end
)

-- Callback to handle citizen calls
RegisterNUICallback(
    "citizenCall",
    function(data, cb)
        print_debug("RECEIVED REQUEST FROM NUI TO SEND CITIZEN CALL")
        print_debug("SENDING CITIZEN CALL OBJECT TO SERVER")
        TriggerServerEvent("citizen_call", data)
        if cb then
            cb('Sent')
        end
    end
)

-- Callback to handle citizen offences retrieval
RegisterNUICallback(
    "getCitizenOffences",
    function(data, cb)
        -- Tell the server to send the init data
        print_debug("RECEIVED REQUEST FROM NUI TO GET CITIZEN OFFENCES")
        print_debug("SENDING GET CITIZEN OFFENCES REQUEST TO SERVER")
        TriggerServerEvent("get_citizen_offences", data)
        if cb then
            cb()
        end
    end
)

-- Callback to handle removal of user from unit
RegisterNUICallback(
    "removeUserFromUnit",
    function(data, cb)
        -- Tell the server to remove the user from the unit
        print_debug("RECEIVED REQUEST FROM NUI TO REMOVE USER " .. data.userId .. " FROM UNIT " .. data.unitId)
        print_debug("SENDING REMOVE USER FROM UNIT REQUEST TO SERVER")
        TriggerServerEvent("remove_user_from_unit", data)
        if cb then
            cb()
        end
    end
)

-- Callback to handle addition of user to unit
RegisterNUICallback(
    "addUserToUnit",
    function(data, cb)
        -- Tell the server to add the user to the unit
        print_debug("RECEIVED REQUEST FROM NUI TO ADD USER " .. data.userId .. " TO UNIT " .. data.unitId)
        print_debug("SENDING ADD USER TO UNIT REQUEST TO SERVER")
        TriggerServerEvent("add_user_to_unit", data)
        if cb then
            cb()
        end
    end
)

-- Callback to handle addition of user to unit
RegisterNUICallback(
    "setUnitState",
    function(data, cb)
        -- Tell the server to set the state of the unit
        print_debug("RECEIVED REQUEST FROM NUI TO SET STATE OF UNIT " .. data.unitId .. " TO STATE " .. data.stateId)
        print_debug("SENDING SET UNIT STATE REQUEST TO SERVER")
        TriggerServerEvent("set_unit_state", data)
        if cb then
            cb()
        end
    end
)

-- Callback to handle addition of a marker
RegisterNUICallback(
    "addMarker",
    function(data, cb)
        -- Tell the server to add the marker
        print_debug("RECEIVED REQUEST FROM NUI TO ADD MARKER " .. data.markerId .. " TO " .. data.type .. " " .. data.typeId)
        print_debug("SENDING MARKER ADDITION REQUEST TO SERVER")
        TriggerServerEvent("add_marker", data)
        if cb then
            cb()
        end
    end
)

-- Callback to handle removal of a marker
RegisterNUICallback(
    "removeMarker",
    function(data, cb)
        -- Tell the server to add the marker
        print_debug("RECEIVED REQUEST FROM NUI TO REMOVE MARKER " .. data.markerId .. " FROM " .. data.type .. " " .. data.typeId)
        print_debug("SENDING MARKER REMOVAL REQUEST TO SERVER")
        TriggerServerEvent("remove_marker", data)
        if cb then
            cb()
        end
    end
)

-- Callback to handle setting of call marker
RegisterNUICallback(
    "setCallMarker",
    function(data, cb)
        -- Add the marker
        print_debug("RECEIVED REQUEST FROM NUI TO SET MARKER FOR CALL " .. data.call.id)
        set_call_marker(data.call)
        if cb then
            cb()
        end
    end
)

-- Callback to handle setting of call route
RegisterNUICallback(
    "setCallRoute",
    function(data, cb)
        -- Add the route
        print_debug("RECEIVED REQUEST FROM NUI TO SET ROUTE")
        set_call_route()
        if cb then
            cb()
        end
    end
)

-- Callback to handle removal of call marker
RegisterNUICallback(
    "clearCallMarker",
    function(data, cb)
        -- Remove the marker
        print_debug("RECEIVED REQUEST FROM NUI TO REMOVE MARKER")
        clear_call_marker()
        if cb then
            cb()
        end
    end
)

-- Callback to handle removal of all call routes
RegisterNUICallback(
    "clearCallRoute",
    function(cb)
        -- Remove the routes
        print_debug("RECEIVED REQUEST FROM NUI TO REMOVE ROUTE")
        clear_call_route()
        if cb then
            cb()
        end
    end
)

-- Callback to handle saving of an offence's metadata
RegisterNUICallback(
    "sendOffenceMeta",
    function(data, cb)
        -- Tell the server to send the metadata
        print_debug("RECEIVED REQUEST FROM NUI TO SAVE OFFENCE METADATA")
        print_debug("SENDING METADATA SAVE REQUEST TO SERVER")
        TriggerServerEvent("send_offence_metadata", data)
        if cb then
            cb()
        end
    end
)

-- Callback to handle saving of a call
RegisterNUICallback(
    "sendCall",
    function(data, cb)
        -- Tell the server to send the call
        print_debug("RECEIVED REQUEST FROM NUI TO SAVE CALL")
        print_debug("SENDING CALL SAVE REQUEST TO SERVER")
        TriggerServerEvent("send_call", data)
        if cb then
            cb()
        end
    end
)

-- Callback to handle saving of a BOLO
RegisterNUICallback(
    "sendBolo",
    function(data, cb)
        -- Tell the server to send the call
        print_debug("RECEIVED REQUEST FROM NUI TO SAVE BOLO")
        print_debug("SENDING BOLO SAVE REQUEST TO SERVER")
        TriggerServerEvent("send_bolo", data)
        if cb then
            cb()
        end
    end
)

-- Callback to handle deleting of a call
RegisterNUICallback(
    "deleteCall",
    function(data, cb)
        -- Tell the server to delete the call
        print_debug("RECEIVED REQUEST FROM NUI TO DELETE CALL")
        print_debug("SENDING CALL DELETE REQUEST TO SERVER")
        TriggerServerEvent("delete_call", data)
        if cb then
            cb()
        end
    end
)

RegisterNUICallback(
    "deleteBolo",
    function(data, cb)
        -- Tell the server to delete the call
        print_debug("RECEIVED REQUEST FROM NUI TO DELETE BOLO")
        print_debug("SENDING BOLO DELETE REQUEST TO SERVER")
        TriggerServerEvent("delete_bolo", data)
        if cb then
            cb()
        end
    end
)

-- Callback to handle saving of a unit
RegisterNUICallback(
    "sendUnit",
    function(data, cb)
        -- Tell the server to send the call
        print_debug("RECEIVED REQUEST FROM NUI TO SAVE UNIT")
        print_debug("SENDING UNIT SAVE REQUEST TO SERVER")
        TriggerServerEvent("send_unit", data)
        if cb then
            cb()
        end
    end
)

-- Callback to handle deleting of a call
RegisterNUICallback(
    "deleteUnit",
    function(data, cb)
        -- Tell the server to delete the call
        print_debug("RECEIVED REQUEST FROM NUI TO DELETE UNIT")
        print_debug("SENDING UNIT DELETE REQUEST TO SERVER")
        TriggerServerEvent("delete_unit", data)
        if cb then
            cb()
        end
    end
)

-- Callback to handle saving of a ticket
RegisterNUICallback(
    "saveTicket",
    function(data, cb)
        -- Tell the server to do it
        print_debug("RECEIVED REQUEST FROM NUI TO SAVE TICKET")
        print_debug("SENDING TICKET SAVE REQUEST TO SERVER")
        TriggerServerEvent("save_ticket", data)
        if cb then
            cb()
        end
    end
)

-- Callback to handle saving of an arrest
RegisterNUICallback(
    "saveArrest",
    function(data, cb)
        -- Tell the server to do it
        print_debug("RECEIVED REQUEST FROM NUI TO SAVE ARREST")
        print_debug("SENDING ARREST SAVE REQUEST TO SERVER")
        TriggerServerEvent("save_arrest", data)
        if cb then
            cb()
        end
    end
)

RegisterNUICallback(
    "deleteOffence",
    function(data, cb)
        -- Tell the server to delete the offence
        print_debug("RECEIVED REQUEST FROM NUI TO DELETE OFFENCE")
        print_debug("SENDING DELETE OFFENCE REQUEST TO SERVER")
        TriggerServerEvent("delete_offence", data)
        if cb then
            cb()
        end
    end
)

-- Callback for stopping terminal dragging
RegisterNUICallback(
    "terminalDraggingStop",
    function(_, cb)
        -- Tell the server to start the panic
        print_debug("RECEIVED REQUEST FROM NUI TO STOP TERMINAL DRAGGING")
        print_debug("SENDING STOP TERMINAL DRAGGING REQUEST TO SERVER")
        TriggerServerEvent("terminal_drag_toggle")
        if cb then
            cb()
        end
    end
)

-- Callback for toggling a unit assignment
RegisterNUICallback(
    "toggleAssignment",
    function(data, cb)
        -- Tell the server to toggle the assignment
        print_debug("RECEIVED REQUEST FROM NUI TO TOGGLE UNIT ASSIGNMENT")
        print_debug("SENDING TOGGLE UNIT ASSIGNMENT REQUEST TO SERVER")
        TriggerServerEvent("toggle_assignment", data)
        if cb then
            cb()
        end
    end
)

local active_blip

function set_call_marker(call)
    -- For now, we're only allowing a single call marker
    -- Clear any prexisting markers or routes
    clear_call_marker()
    clear_call_route()
    local blip = AddBlipForCoord(call.markerX, call.markerY)
    SetBlipSprite(blip, 398)
    SetBlipColour(blip, 0)
    SetBlipDisplay(blip, 2)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("String")
    AddTextComponentString(call.callType.name .. ' - ' .. call.callGrade.name)
    EndTextCommandSetBlipName(blip)
    active_blip = blip
end

function clear_call_marker()
    if (active_blip ~= nil) then
        RemoveBlip(active_blip)
    end
end

function set_call_route()
    if (active_blip ~= nil) then
        clear_call_route()
        SetBlipRoute(active_blip, true)
    end
end

function clear_call_route()
    if (active_blip ~= nil) then
        SetBlipRoute(active_blip, false)
    end
end
