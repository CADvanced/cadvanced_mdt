local queries = module("server/modules/queries")
local client_sender = module("server/modules/comms/client_sender")
local api = module("server/modules/comms/api")

local vehicles = {}

-- Get the table of vehicle markers
function vehicles.get_all_markers(pass_to_client)
    local q_get_all_vehicle_markers = queries.get_all_vehicle_markers()
    api.request(
        q_get_all_vehicle_markers,
        function(response)
            response = json.decode(response)
            if response.error == nil then
                local vehicle_markers = {}
                for _, marker in ipairs(response.data.allVehicleMarkers) do
                    table.insert(vehicle_markers, marker)
                end
                state_set("vehicle_markers", vehicle_markers)
                if (pass_to_client ~= nil and pass_to_client) then
                    client_sender.pass_data(state.vehicle_markers, "vehicle_markers")
                end
            else
                print_debug(response.error)
            end
        end
    )
end

-- Repopulate all vehicle_markers
function vehicles.repopulate_vehicle_markers()
    vehicles.get_all_markers(true)
end

-- Get the table of vehicle models
function vehicles.get_all_models(pass_to_client)
    local q_get_all_vehicle_models = queries.get_all_vehicle_models()
    api.request(
        q_get_all_vehicle_models,
        function(response)
            response = json.decode(response)
            if response.error == nil then
                local vehicle_models = {}
                for _, model in ipairs(response.data.allVehicleModels) do
                    table.insert(vehicle_models, model)
                end
                state_set("vehicle_models", vehicle_models)
                if (pass_to_client ~= nil and pass_to_client) then
                    client_sender.pass_data(state.vehicle_models, "vehicle_models")
                end
            else
                print_debug(response.error)
            end
        end
    )
end

-- Repopulate all vehicle_models
function vehicles.repopulate_vehicle_models()
    vehicles.get_all_models(true)
end

-- Add a marker to a vehicle
function vehicles.add_marker(data)
    local q_attach_marker_to_vehicle = queries.attach_marker_to_vehicle(data)
    api.request(
        q_attach_marker_to_vehicle,
        function(response)
            response = json.decode(response)
            if response.error ~= nil then
                print_debug(response.error)
            end
        end
    )
end

-- Remove a marker from a vehicle
function vehicles.remove_marker(data)
    local q_detach_marker_from_vehicle = queries.detach_marker_from_vehicle(data)
    api.request(
        q_detach_marker_from_vehicle,
        function(response)
            response = json.decode(response)
            if response.error ~= nil then
                print_debug(response.error)
            end
        end
    )
end

function vehicles.search_vehicles(search, callback, src)
    local q_search_vehicles = queries.search_vehicles(search)
    api.request(
        q_search_vehicles,
        function(response)
            response = json.decode(response)
            if response.error == nil then
                local received = response.data.searchVehicles
                -- Send client the search results
                print_debug("SENDING ALL CLIENTS VEHICLE SEARCH RESULTS")
                callback(received, "vehicle_search_results", src)
            else
                print_debug(response.error)
            end
        end
    )
end

return vehicles