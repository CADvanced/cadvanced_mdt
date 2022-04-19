local users = module("server/modules/users")
local units = module("server/modules/units")
local calls = module("server/modules/calls")
local bolos = module("server/modules/bolos")
local vehicles = module("server/modules/vehicles")
local citizens = module("server/modules/citizens")
local departments = module("server/modules/departments")
local preferences = module("server/modules/preferences")
local cad_config = module("server/modules/cad_config")

SetHttpHandler(
    function(req, res)
        print_debug("ROUTER RECEIVED REQUEST TO " .. req.path)
        if req.method == "POST" then
            if req.path == "/update" then
                req.setDataHandler(
                    function(body)
                        print_debug("POST ROUTER RECEIVED " .. body)
                        local data = json.decode(body)
                        local response = "OK"
                        if next(data) ~= nil then
                            print_debug("HANDLING UPDATED " .. data.object)
                            if (data.object == "user") then
                                -- We will receive the Steam ID of a user we
                                -- need to update our cache of
                                users.populate_player(data.payload.steamId)
                            elseif (data.object == "unit") then
                                -- Update a given unit
                                units.update_unit(data.payload.unitId)
                            elseif (data.object == "call") then
                                -- Update a given call
                                calls.update_call(data.payload.callId)
                            elseif (data.object == "citizen") then
                                -- Update a given citizen
                                citizens.update_citizen(data.payload.citizenId)
                            elseif (data.object == "calls") then
                                -- Update all calls
                                calls.repopulate_calls()
                            elseif (data.object == "preference") then
                                -- Update preference
                                local key = data.payload.key;
                                if (key == "enable_bolo") then
                                    preferences.repopulate_preference(data.payload.key)
                                end
                            elseif (data.object == "user_units") then
                                -- Repopulate all user / unit assignments
                                units.repopulate_user_units()
                            elseif (data.object == "citizen_markers") then
                                -- Repopulate all citizen markers
                                citizens.repopulate_citizen_markers()
                            elseif (data.object == "vehicle_markers") then
                                -- Repopulate all vehicle markers
                                vehicles.repopulate_vehicle_markers()
                            elseif (data.object == "vehicle_models") then
                                -- Repopulate all vehicle models
                                vehicles.repopulate_vehicle_models()
                            elseif (data.object == "unit_states") then
                                -- Repopulate all unit states
                                units.repopulate_unit_states()
                            elseif (data.object == "unit_types") then
                                -- Repopulate all unit types
                                units.repopulate_unit_types()
                            elseif (data.object == "user_ranks") then
                                -- Repopulate all user ranks
                                users.repopulate_user_ranks()
                            elseif (data.object == "units") then
                                -- Repopulate all units
                                units.repopulate_units()
                            elseif (data.object == "bolos") then
                                -- Repopulate all BOLOs
                                bolos.repopulate_bolos()
                            elseif (data.object == "departments") then
                                -- Update all departments
                                departments.repopulate_departments()
                            elseif (data.object == "department_announcements") then
                                -- Update all department announcements
                                departments.repopulate_department_announcements()
                            elseif (data.object == "whitelist") then
                                -- Repopulate the whitelist
                                users.get_whitelisted()
                            elseif (data.object == "panic") then
                                -- We've got a panic
                                users.display_panic(data.payload.callId)
                            elseif (data.object == "cad_config") then
                                -- We've received an updated config
                                local updated = cad_config.receive_update(data.payload)
                                if (not updated) then
                                    response = "FAIL"
                                end
                            end
                        end
                        res.send(json.encode({
                            result = response,
                            cadvanced_mdt_version = GetResourceMetadata('cadvanced_mdt', 'version', 0)
                        }))
                    end
                )
            end
        elseif req.method == "GET" then
            print_debug("GET ROUTER RESPONDING")
            if req.path == "/locations" then
                local user_locations = users.get_locations()
                res.send(json.encode({
                    userLocations = user_locations,
                    cadvanced_mdt_version = GetResourceMetadata('cadvanced_mdt', 'version', 0)
                }))
            elseif req.path == '/version' then
                local version = GetResourceMetadata('cadvanced_mdt', 'version', 0)
                res.send(json.encode({version = version }))
            end
        end
    end
)
