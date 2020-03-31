function print_debug(content)
    local conf = state_get("config")
    if conf.debug then
        print("CADVANCED CLIENT: " .. content)
    end
end