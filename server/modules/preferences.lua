local queries = module("server/modules/queries")
local client_sender = module("server/modules/comms/client_sender")
local api = module("server/modules/comms/api")

local preferences = {}

-- Get a preference
function preferences.get_preference(key, pass_to_client)
    local q_get_preference = queries.get_preference(key)
    api.request(
        q_get_preference,
        function(response)
            response = json.decode(response)
            if response.error == nil then
                local pref_name = "preference_"..key;
                state_set(pref_name, response.data.getPreference.value)
                if (pass_to_client ~= nil and pass_to_client) then
                    client_sender.pass_data(state[pref_name], pref_name)
                end
            else
                print_debug(response.error)
            end
        end
    )
end
-- Repopulate preference
function preferences.repopulate_preference(key)
    preferences.get_preference(key, true)
end

return preferences
