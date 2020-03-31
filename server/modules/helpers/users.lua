local user_helpers = {}

-- Get the player's Steam ID
function user_helpers.get_steam_id(source)
    local id = nil
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            local trimmed = v:gsub("steam:", "")
            id = trimmed
            break
        end
    end
    return id
end

return user_helpers
