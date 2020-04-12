local init = module("server/modules/init")

-- Create a name for a logging tempfile
state_set("temp_file", os.tmpname() .. ".log")

-- Bootstrap data population
init.bootstrapData()

-- Create handlers for server events
init.createEventHandlers()

-- Start any long running tasks
init.startTasks()