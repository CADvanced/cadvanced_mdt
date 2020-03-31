Citizen.CreateThread(function()
    while true do
        local pos = GetEntityCoords(GetPlayerPed(-1))
        print_debug("SENDING LOCATION TO SERVER")
        TriggerServerEvent('update_location', { x = pos.x, y = pos.y })
        Citizen.Wait(5000)
    end
end)
