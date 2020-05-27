local conf = module("mdt_config")

local config = {}

-- Return a config value
function config.val(key)
    return conf[key]
end

-- Check the loaded config for sanity
function config.sanity_check()
    if conf then
        if conf.cad_url == nil or conf.cad_url == "https://yourcad.cadvanced.app" then
            print("****** CADVANCED: Invalid or missing cad_url value in config ******")
            return false
        end
        if conf.api_token == nil or conf.api_token == "" then
            print("****** CADVANCED: Invalid or missing api_token value in config ******")
            return false
        end
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
        return true
    else
        print(
            "****** CADVANCED: UNABLE TO LOAD CONFIG. File mdt_config.lua was not found. Please create a config file (using config.lua.sample as an example). Then try again ******"
        )
        return false
    end
end

return config
