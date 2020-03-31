-- Command handling
RegisterCommand(
    "mdt",
    function(source)
        TriggerServerEvent("open_mdt")
    end,
    false -- Allow anyone to issue this command
)
