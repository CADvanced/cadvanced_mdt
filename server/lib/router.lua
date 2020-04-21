local users = module("server/modules/users")
local units = module("server/modules/units")
local calls = module("server/modules/calls")
local vehicles = module("server/modules/vehicles")
local citizens = module("server/modules/citizens")

SetHttpHandler(
    function(req, res)
        print_debug("ROUTER RECEIVED REQUEST TO " .. req.path)
        if req.method == "POST" then
            if req.path == "/update" then
                req.setDataHandler(
                    function(body)
                        print_debug("PUT ROUTER RECEIVED " .. body)
                        local data = json.decode(body)
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
                            elseif (data.object == "calls") then
                                -- Update all calls
                                calls.repopulate_calls()
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
                            elseif (data.object == "user_ranks") then
                                -- Repopulate all user ranks
                                users.repopulate_user_ranks()
                            elseif (data.object == "units") then
                                -- Repopulate all units
                                units.repopulate_units()
                            elseif (data.object == "whitelist") then
                                -- Repopulate the whitelist
                                users.get_whitelisted()
                            end
                        end
                        res.send(json.encode({
                            result = "OK",
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
