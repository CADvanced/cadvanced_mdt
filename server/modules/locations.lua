local queries = module("server/modules/queries")
local client_sender = module("server/modules/comms/client_sender")
local api = module("server/modules/comms/api")

local locations = {}

-- Get the table of locations
function locations.get_all_locations(pass_to_client)
    local q_get_all_locations = queries.get_all_locations()
    api.request(
        q_get_all_locations,
        function(response)
            response = json.decode(response)
            if response.error == nil then
                local location_list = {}
                for _, location in ipairs(response.data.allLocations) do
                    table.insert(location_list, location)
                end
                state_set("locations", location_list)
                if (pass_to_client ~= nil and pass_to_client) then
                    client_sender.pass_data(state.locations, "locations")
                end
            else
                print_debug(response.error)
            end
        end
    )
end

return locations