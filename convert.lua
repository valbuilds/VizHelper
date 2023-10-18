function convertTableToCondensedString(tbl)
    local str = ""
    for i, num in ipairs(tbl) do
        str = str .. string.format("%.1f", num)
        if i < #tbl then
            str = str .. "/"
        end
    end
    return str
end