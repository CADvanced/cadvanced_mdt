local modules = {}

-- load a lua resource file as module (for a specific side)
-- path: lua file path without extension
-- Shamelessly borrowed from:
-- https://github.com/ImagicTheCat/vRP/blob/master/vrp/lib/utils.lua
function module(path)
    local module = modules[path]
    if module then -- cached module
        return module
    else
        local code = LoadResourceFile("cadvanced_mdt", path .. ".lua")
        if code then
            local f, err = load(code, "/" .. path .. ".lua")
            if f then
                local ok, res = xpcall(f, debug.traceback)
                if ok then
                    modules[path] = res
                    return res
                else
                    error("error loading module " .. path .. ":" .. res)
                end
            else
                error("error parsing module " .. path .. ":" .. debug.traceback(err))
            end
        else
            return false
        end
    end
end

-- Does a user have an active officer
function hasOfficer(userSource)
    local users = state_get("users")
    local has = false
    for i, iter in ipairs(users) do
        if (
            userSource == iter.source and
            iter.character and
            iter.character.__typename == "Officer"
        ) then
            has = true
            break
        end
    end
    return has;
end

-- Does a user have an active citizen
function hasCitizen(userSource)
    local users = state_get("users")
    local has = false
    for i, iter in ipairs(users) do
        if (
            userSource == iter.source and
            iter.character and
            iter.character.__typename == "Citizen"
        ) then
            has = true
            break
        end
    end
    return has;
end

-- Generic "check if value is in array" function
function hasValue(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

-- Dump a table's contents to the console
function dump_table(tbl)
    print_debug(tprint(tbl))
end

-- Serialize a table
function tprint(tbl, indent)
    if not indent then
        indent = 0
    end
    local toprint = string.rep(" ", indent) .. "{\r\n"
    indent = indent + 2
    for k, v in pairs(tbl) do
        toprint = toprint .. string.rep(" ", indent)
        if (type(k) == "number") then
            toprint = toprint .. "[" .. k .. "] = "
        elseif (type(k) == "string") then
            toprint = toprint .. k .. "= "
        end
        if (type(v) == "number") then
            toprint = toprint .. v .. ",\r\n"
        elseif (type(v) == "string") then
            toprint = toprint .. '"' .. v .. '",\r\n'
        elseif (type(v) == "table") then
            toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
        else
            toprint = toprint .. '"' .. tostring(v) .. '",\r\n'
        end
    end
    toprint = toprint .. string.rep(" ", indent - 2) .. "}"
    return toprint
end