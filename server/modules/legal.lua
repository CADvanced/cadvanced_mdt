local queries = module("server/modules/queries")
local client_sender = module("server/modules/comms/client_sender")
local api = module("server/modules/comms/api")

local legal = {}

-- Get the table of all charges
function legal.get_all_charges(pass_to_client)
    local q_get_all_charges = queries.get_all_charges()
    api.request(
        q_get_all_charges,
        function(response)
            response = json.decode(response)
            if response.error == nil then
                local charges = {}
                for _, charge in ipairs(response.data.allCharges) do
                    table.insert(charges, charge)
                end
                state_set("charges", charges)
                if (pass_to_client ~= nil and pass_to_client) then
                    client_sender.pass_data(state.charges, "charges")
                end
            else
                print_debug(response.error)
            end
        end
    )
end

-- Send an offence's metadata
function legal.send_offence_metadata(data)
    local q_send_offence_metadata
    if (data.id) then
        q_send_offence_metadata = queries.update_offence(data)
    else
        q_send_offence_metadata = queries.create_offence(data)
    end
    api.request(
        q_send_offence_metadata,
        function(response)
            response = json.decode(response)
            if response.error ~= nil then
                print_debug(response.error)
            end
        end
    )
end

-- Save a ticket
function legal.save_ticket(data)
    local q_save_ticket
    if (data.id) then
        q_save_ticket = queries.update_ticket(data)
    else
        q_save_ticket = queries.create_ticket(data)
    end
    api.request(
        q_save_ticket,
        function(response)
            response = json.decode(response)
            if response.error ~= nil then
                print_debug(response.error)
            end
        end
    )
end

-- Save an arrest
function legal.save_arrest(data)
    local q_save_arrest
    if (data.id) then
        q_save_arrest = queries.update_arrest(data)
    else
        q_save_arrest = queries.create_arrest(data)
    end
    api.request(
        q_save_arrest,
        function(response)
            response = json.decode(response)
            if response.error ~= nil then
                print_debug(response.error)
            end
        end
    )
end

-- Delete an offence
function legal.delete_offence(data)
    local q_delete_offence = queries.delete_offence(data)
    api.request(
        q_delete_offence,
        function(response)
            response = json.decode(response)
            if response.error ~= nil then
                print_debug(response.error)
            end
        end
    )
end

return legal