local queries = module("server/modules/queries")
local client_sender = module("server/modules/comms/client_sender")
local api = module("server/modules/comms/api")

local calls = {}

-- Get the table of all calls
function calls.get_all_calls(pass_to_client)
    local q_all_calls = queries.get_all_calls()
    api.request(
        q_all_calls,
        function(response)
            response = json.decode(response)
            if response.error == nil then
                local cll = {}
                for _, call in ipairs(response.data.allCalls) do
                    table.insert(cll, call)
                end
                state_set("calls", cll)
                if (pass_to_client ~= nil and pass_to_client) then
                    client_sender.pass_data(state.calls, "calls")
                end
            else
                print_debug(response.error)
            end
        end
    )
end

-- Update a call
function calls.update_call(id)
    local q_get_call = queries.get_call(id)
    print_debug("UPDATING CALL " .. id)
    api.request(
        q_get_call,
        function(response)
            response = json.decode(response)
            if response.error == nil then
                print_debug("PARSING UPDATED CALL")
                local received = response.data.getCall
                local ex_calls = state_get("calls")
                local found = false
                for i, iter in ipairs(ex_calls) do
                    if (iter.id == received.id) then
                        ex_calls[i] = received
                        found = true
                    end
                end
                if not found then
                    table.insert(ex_calls, received)
                end
                state_set("calls", ex_calls)
                -- Send client the updated calls list
                print_debug("SENDING ALL CLIENTS UPDATED CALLS")
                client_sender.pass_data(ex_calls, "calls")
            else
                print_debug(response.error)
            end
        end
    )
end

-- Repopulate all calls
function calls.repopulate_calls()
    calls.get_all_calls(true)
end

-- Get the table of all call grades
function calls.get_all_call_grades(pass_to_client)
    local q_get_all_call_grades = queries.get_all_call_grades()
    api.request(
        q_get_all_call_grades,
        function(response)
            response = json.decode(response)
            if response.error == nil then
                local call_grades = {}
                for _, grade in ipairs(response.data.allCallGrades) do
                    table.insert(call_grades, grade)
                end
                state_set("call_grades", call_grades)
                if (pass_to_client ~= nil and pass_to_client) then
                    client_sender.pass_data(state.call_grades, "call_grades")
                end
            else
                print_debug(response.error)
            end
        end
    )
end

-- Get the table of all call types
function calls.get_all_call_types(pass_to_client)
    local q_get_all_call_types = queries.get_all_call_types()
    api.request(
        q_get_all_call_types,
        function(response)
            response = json.decode(response)
            if response.error == nil then
                local call_types = {}
                for _, call_type in ipairs(response.data.allCallTypes) do
                    table.insert(call_types, call_type)
                end
                state_set("call_types", call_types)
                if (pass_to_client ~= nil and pass_to_client) then
                    client_sender.pass_data(state.call_types, "call_types")
                end
            else
                print_debug(response.error)
            end
        end
    )
end

-- Get the table of all call incidents
function calls.get_all_call_incidents(pass_to_client)
    local q_get_all_call_incidents = queries.get_all_call_incidents()
    api.request(
        q_get_all_call_incidents,
        function(response)
            response = json.decode(response)
            if response.error == nil then
                local call_incidents = {}
                for _, call_incident in ipairs(response.data.allIncidentTypes) do
                    table.insert(call_incidents, call_incident)
                end
                state_set("call_incidents", call_incidents)
                if (pass_to_client ~= nil and pass_to_client) then
                    client_sender.pass_data(state.call_incidents, "call_incidents")
                end
            else
                print_debug(response.error)
            end
        end
    )
end

-- Send a call
function calls.send_call(data)
    local q_send_call
    if (data.id) then
        q_send_call = queries.update_call(data)
    else
        q_send_call = queries.create_call(data)
    end
    api.request(
        q_send_call,
        function(response)
            response = json.decode(response)
            if response.error ~= nil then
                print_debug(response.error)
            end
        end
    )
end

-- Delete a call
function calls.delete_call(data)
    local q_delete_call = queries.delete_call(data)
    api.request(
        q_delete_call,
        function(response)
            response = json.decode(response)
            if response.error ~= nil then
                print_debug(response.error)
            end
        end
    )
end

-- Toggle a unit assignment
function calls.toggle_assignment(data)
    local q_toggle_assignment = queries.toggle_assignment(data)
    api.request(
        q_toggle_assignment,
        function(response)
            response = json.decode(response)
            if response.error ~= nil then
                print_debug(response.error)
            end
        end
    )
end

return calls
