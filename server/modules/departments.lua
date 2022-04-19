local queries = module("server/modules/queries")
local client_sender = module("server/modules/comms/client_sender")
local api = module("server/modules/comms/api")

local departments = {}

-- Repopulate all department announcements
function departments.repopulate_department_announcements()
    departments.get_department_announcements()
end

-- Get all department announcements
function departments.get_department_announcements()
    local q_all_department_announcements = queries.get_department_announcements()
    api.request(
        q_all_department_announcements,
        function(response)
            response = json.decode(response)
            if response.error == nil then
                local department_announcements_table = {}
                for _, ann in ipairs(response.data.allDepartmentAnnouncements) do
                    table.insert(department_announcements_table, ann)
                end
                state_set("department_announcements", department_announcements_table)
                client_sender.pass_data(state.department_announcements, "department_announcements")
            else
                print_debug(response.error)
            end
        end
    )
end

-- Repopulate all departments
function departments.repopulate_departments()
    departments.get_all_departments(true)
end

-- Get all departments
function departments.get_all_departments(pass_to_client)
    local q_all_departments = queries.get_all_departments()
    api.request(
        q_all_departments,
        function(response)
            response = json.decode(response)
            if response.error == nil then
                local departments_table = {}
                for _, dept in ipairs(response.data.allDepartments) do
                    table.insert(departments_table, dept)
                end
                state_set("departments", departments_table)
                if (pass_to_client ~= nil and pass_to_client) then
                    client_sender.pass_data(state.departments, "departments")
                end
            else
                print_debug(response.error)
            end
        end
    )
end

return departments;
