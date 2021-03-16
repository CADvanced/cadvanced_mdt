local api = {}

function api.request(query, callback)
    local conf = module("server/modules/config")
    local token = conf.val("api_token")
    local url = conf.val("cad_url") .. "/api"
    print_debug("MAKING API CALL TO " .. url)
    print_debug("CALL BODY: " .. query)
    PerformHttpRequest(
        url,
        function(errorCode, resultData)
            if errorCode ~= 200 then
                print_debug("CADvanced: ERROR - Unable to perform query " .. query .. ", error " .. errorCode)
                callback({error = errorCode})
            end
            print_debug("CALL RESPONSE: " .. resultData)
            callback(resultData)
        end,
        "POST",
        query,
        {
            ["Content-Type"] = "application/json",
            ["cadvanced-token"] = token,
            ["cadvanced-mdt-version"] = GetResourceMetadata('cadvanced_mdt', 'version', 0)
        }
    )
end

return api
