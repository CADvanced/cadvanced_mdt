local queries = module("server/modules/queries")
local client_sender = module("server/modules/comms/client_sender")
local api = module("server/modules/comms/api")

local bolos = {}

-- Send a BOLO
function bolos.send_bolo(data)
    local q_send_bolo
    if (data.id) then
        q_send_bolo = queries.update_bolo(data)
    else
        q_send_bolo = queries.create_bolo(data)
    end
    api.request(
        q_send_bolo,
        function(response)
            response = json.decode(response)
            if response.error ~= nil then
                print_debug(response.error)
            end
        end
    )
end

-- Delete a BOLO
function bolos.delete_bolo(data)
    local q_delete_bolo = queries.delete_bolo(data)
    api.request(
        q_delete_bolo,
        function(response)
            response = json.decode(response)
            if response.error ~= nil then
                print_debug(response.error)
            end
        end
    )
end

-- Get the table of all BOLOs
function bolos.get_all_bolos(pass_to_client)
    local q_all_bolos = queries.get_all_bolos()
    api.request(
        q_all_bolos,
        function(response)
            response = json.decode(response)
            if response.error == nil then
                local bolo_table = {}
                for _, bolo in ipairs(response.data.allBolos) do
                    table.insert(bolo_table, bolo)
                end
                state_set("bolos", bolo_table)
                if (pass_to_client ~= nil and pass_to_client) then
                    client_sender.pass_data(state.bolos, "bolos")
                end
            else
                print_debug(response.error)
            end
        end
    )
end

-- Update a BOLO
function bolos.update_bolo(id)
    local q_get_bolo = queries.get_bolo(id)
    print_debug("UPDATING BOLO " .. id)
    api.request(
        q_get_bolo,
        function(response)
            response = json.decode(response)
            if response.error == nil then
                print_debug("PARSING UPDATED BOLO")
                local received = response.data.getBolo
                local ex_bolos = state_get("bolos")
                local found = false
                for i, iter in ipairs(ex_bolos) do
                    if (iter.id == received.id) then
                        ex_bolos[i] = received
                        found = true
                    end
                end
                if not found then
                    table.insert(ex_bolos, received)
                end
                state_set("bolos", ex_bolos)
                -- Send client the updated BOLOs list
                print_debug("SENDING ALL CLIENTS UPDATED BOLOS")
                client_sender.pass_data(ex_bolos, "bolos")
            else
                print_debug(response.error)
            end
        end
    )
end

-- Repopulate all BOLOs
function bolos.repopulate_bolos()
    bolos.get_all_bolos(true)
end

return bolos
