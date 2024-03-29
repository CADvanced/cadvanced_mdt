local conf = module("server/modules/config")
local users = module("server/modules/users")
local calls = module("server/modules/calls")
local bolos = module("server/modules/bolos")
local units = module("server/modules/units")
local citizens = module("server/modules/citizens")
local vehicles = module("server/modules/vehicles")
local legal = module("server/modules/legal")
local locations = module("server/modules/locations")
local calls = module("server/modules/calls")
local departments = module("server/modules/departments")
local preferences = module("server/modules/preferences")
local client_receiver = module("server/modules/comms/client_receiver")

local init = {}

-- Bootstrap our local data model
function init.bootstrapData()
    -- Check we have a valid config
    local sane = conf.sanity_check()
    if not sane then
        return
    end
    
    -- Sanity check and get CAD config
    local cad_config_sane = conf.get_cad_config()
    if not cad_config_sane then
        return
    end

    -- Get the whitelisted players, if appropriate
    users.get_whitelisted()

    -- Get all calls
    calls.get_all_calls(true)

    -- Get all BOLOs
    bolos.get_all_bolos(true)

    -- Get all units
    units.get_all_units(true)

    -- Get all unit states
    units.get_all_unit_states(true)

    -- Get all unit types
    units.get_all_unit_types(true)

    -- Get all user / unit assignments
    units.get_all_user_units(true)

    -- Get all user ranks
    users.get_all_user_ranks(true)

    -- Get all citizen markers
    citizens.get_all_markers(true)

    -- Get all vehicle markers
    vehicles.get_all_markers(true)

    -- Get all vehicle models
    vehicles.get_all_models(true)

    -- Get all charges
    legal.get_all_charges(true)

    -- Get all call grades
    calls.get_all_call_grades(true)

    -- Get all call grades
    calls.get_all_call_types(true)

    -- Get all call incidents
    calls.get_all_call_incidents(true)

    -- Get all locations
    locations.get_all_locations(true)

    -- Get all departments
    departments.get_all_departments(true)

    -- Get all department announcements
    departments.get_department_announcements(true)
end

function init.createEventHandlers()
    -- Add the playerConnecting handler
    users.handler_playerConnecting()

    -- Add the playerDropped handler
    users.handler_playerDropped()

    -- Add handling for client initiated events
    client_receiver.client_event_handlers()
end

function init.startTasks()
    -- Purge any user locations that haven't been updated
    -- in the last 10 seconds
    Citizen.CreateThread(function()
        while true do
            local locs = state_get("user_locations")
            local expired = os.time() - 10
            local filtered = {}
            for i, it in ipairs(locs) do
                if it.updated >= expired then
                    table.insert(filtered, it)
                else 
                    print_debug("PURGING LOCATION FOR INACTIVE PLAYER " .. it.steamId)
                end
            end
            state_set("user_locations", filtered)
            Citizen.Wait(7000)
        end
    end)
end

return init
