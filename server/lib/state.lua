state = {}

function state_init(key)
    if not state[key] then
        state[key] = {}
    end
end

function state_get(key)
    if not state[key] then
        state_init(key)
    end
    return state[key]
end

function state_get_value(key, id)
    if not state[key] then
        return
    end
    local value = state[key]
    for _, it in ipairs(value) do
        if (it.id == id) then
            return it
        end
    end
end

function state_set(key, val)
    if not state[key] then
        state_init(key)
    end
    state[key] = val
    print_debug("UPDATED STATE FOR " .. key)
    return state[key]
end
