function print_debug(content)
    local conf = module("server/modules/config")
    if conf.val("debug") then
        print("CADVANCED SERVER: " .. content)
    end
end