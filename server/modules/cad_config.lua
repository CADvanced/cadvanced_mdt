local cad_config = {}

-- Update config from CAD
function cad_config.receive_update(updated_config)
    local data = "###### IMPORTANT CONFIGURATION FILE - DO NOT EDIT OR DELETE ######\n" .. updated_config.url .. "|" .. updated_config.key
    local written = SaveResourceFile(
        "cadvanced_mdt",
        "cad.conf",
        data,
        -1
    )
    return written
end

return cad_config