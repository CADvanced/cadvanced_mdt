local cad_config = {}

-- Update config from CAD
function cad_config.receive_update(updated_config)
    local retval = getResourcePath()
    local conf = io.open(retval .. "/cad.conf", "w")
    conf:write("###### IMPORTANT CONFIGURATION FILE - DO NOT EDIT OR DELETE ######\n")
    conf:write(updated_config.url .. "|" .. updated_config.key)
    io.close(conf)
end

return cad_config