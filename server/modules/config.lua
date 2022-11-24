local conf = module("mdt_config")

local config = {}

-- Return a config value
function config.val(key)
    return conf[key]
end

-- Check the loaded config for sanity
function config.sanity_check()
    if conf then
        if conf.homepage == nil then
            print("****** CADVANCED: Missing 'homepage' entry in config ******")
            return false
        end
        if conf.enable_whitelist == nil then
            print("****** CADVANCED: Missing enable_whitelist value in config ******")
            return false
        end
        if conf.sound_volume == nil then
            print("****** CADVANCED: Missing sound_volume value in config ******")
            return false
        end
        if conf.debug == nil then
            print("****** CADVANCED: Missing debug value in config ******")
            return false
        end
        if conf.panic_command == nil or conf.panic_command == "" then
            print("****** CADVANCED: Missing panic_command value in config ******")
            return false
        end
        if conf.panic_keybind == nil or conf.panic_keybind == "" then
            print("****** CADVANCED: Missing panic_keybind value in config ******")
            return false
        end
        if conf.panic_flash_mdt == nil or conf.panic_flash_mdt == "" then
            print("****** CADVANCED: Missing panic_flash_mdt value in config ******")
            return false
        end
        if conf.panic_play_tone == nil or conf.panic_play_tone == "" then
            print("****** CADVANCED: Missing panic_play_tone value in config ******")
            return false
        end
        if conf.panic_duration == nil or conf.panic_duration == "" then
            print("****** CADVANCED: Missing panic_duration value in config ******")
            return false
        end
        if conf.panic_create_marker == nil or conf.panic_create_marker == "" then
            print("****** CADVANCED: Missing panic_create_marker value in config ******")
            return false
        end
        if conf.terminal_open_command == nil or conf.terminal_open_command == "" then
            print("****** CADVANCED: Missing terminal_open_command value in config ******")
            return false
        end
        if conf.terminal_close_command == nil or conf.terminal_close_command == "" then
            print("****** CADVANCED: Missing terminal_close_command value in config ******")
            return false
        end
        if conf.terminal_open_keybind_second == nil or conf.terminal_open_keybind_second == "" then
            print("****** CADVANCED: Missing terminal_open_keybind_second value in config ******")
            return false
        end
        if conf.terminal_close_keybind_second == nil or conf.terminal_close_keybind_second == "" then
            print("****** CADVANCED: Missing terminal_close_keybind_second value in config ******")
            return false
        end
        if conf.terminal_move_command == nil or conf.terminal_move_command == "" then
            print("****** CADVANCED: Missing terminal_move_command value in config ******")
            return false
        end
        if conf.terminal_move_keybind_second == nil or conf.terminal_move_keybind_second == "" then
            print("****** CADVANCED: Missing terminal_move_keybind_second value in config ******")
            return false
        end
        if conf.call_command == nil or conf.call_command == "" then
            print("****** CADVANCED: Missing call_command value in config ******")
            return false
        end
        if conf.call_keybind_second == nil or conf.call_keybind_second == "" then
            print("****** CADVANCED: Missing call_keybind_second value in config ******")
            return false
        end
        if conf.call_number == nil or conf.call_number == "" then
            print("****** CADVANCED: Missing call_number value in config ******")
            return false
        end
        if conf.call_ring_filename == nil or conf.call_ring_filename == "" then
            print("****** CADVANCED: Missing call_ring_filename value in config ******")
            return false
        end
        if conf.call_busy_filename == nil or conf.call_busy_filename == "" then
            print("****** CADVANCED: Missing call_busy_filename value in config ******")
            return false
        end
        if conf.self_dispatch == nil then
            print("****** CADVANCED: Missing self_dispatch value in config ******")
            return false
        end
        if conf.disable_busy_tone == nil then
            print("****** CADVANCED: Missing disable_busy_tone value in config ******")
            return false
        end
        return true
    else
        print(
            "****** CADVANCED: UNABLE TO LOAD CONFIG. File mdt_config.lua was not found. Please create a config file (using config.lua.sample as an example). Then try again ******"
        )
        return false
    end
end

function config.get_cad_config()
    local retval = getResourcePath()
    local cad_conf = io.open(retval .. "/cad.conf", "r")
    local success = false
    local content = ""
    if cad_conf then
        local count = 0
        for line in cad_conf:lines() do
            if count == 1 then
                content = line
            end
            count = count + 1
        end
        cad_conf:close()
        local url_key = content:split("|")
        local cad_url = url_key[1]
        local cad_key = url_key[2]
        if (cad_url ~= nil and cad_url  ~= "" and cad_key ~= nil and cad_key ~= "") then
            conf.cad_url = url_key[1]
            conf.cad_key = url_key[2]
            return true
        end
    end
    print(
        "****** CADVANCED: UNABLE TO LOAD CAD CONFIG. Please complete details of your FiveM server in Admin > Preferences of your CAD ******"
    )

    -- Attempt to fall back to using values in the config, so we don't break
    -- existing users who have updated their MDT, but not initialised the MDT
    -- from the CAD
    if 
        conf.cad_url ~= nil and
        conf.cad_url ~= "https://yourcad.cadvanced.app" and
        conf.api_token ~= ""
    then
        -- Don't bother updating conf.cad_url because it's come from the config
        -- and is already populated
        print ("****** CADVANCED: FALLING BACK TO MAIN CONFIG VALUES")
        conf.cad_key = conf.api_token
        return true
    end

    return false
end

return config
