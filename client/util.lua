-- Send a chat message
function sendChat(message)
    TriggerEvent("chat:addMessage", {
        color = {255, 0, 0},
        multiline = true,
        args = { "MDT", message }
    })
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