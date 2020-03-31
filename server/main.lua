local init = module("server/modules/init")

-- Bootstrap data population
init.bootstrapData()

-- Create handlers for server events
init.createEventHandlers()

-- Start any long running tasks
init.startTasks()