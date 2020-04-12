function print_debug(content)
    local conf = module("server/modules/config")
    if conf.val("debug") then
        local temp_file = state_get("temp_file")
        print("CADVANCED SERVER: [ " .. temp_file .. " ] " .. content)
        local fh = assert(io.open(temp_file, 'a'))
        if (fh ~= nil) then
            fh:write(os.date() .. " - " .. content .. "\n")
            fh:close()
        else
            print("CADVANCED SERVER: CANNOT WRITE TO LOG FILE " .. fn)
            print(fh)
        end
    end
end