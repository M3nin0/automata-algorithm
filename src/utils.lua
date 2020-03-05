function valueIsInArray(value, values)
    for i, v in ipairs(values) do
        if value == v then
            return true
        end
    end
    return false
end