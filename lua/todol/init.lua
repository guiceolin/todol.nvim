local lyaml = require "lyaml"
local open = io.open
M = {}

local function get_list()
    local file = open("Todol", "rb")
    if not file then return nil end
    local content = file:read "*a"
    file:close()
    return lyaml.load(content)
end

local function save_list(content)
    local file = open("Todol", "wb")
    if not file then return nil end
    content = lyaml.dump({content})
    file:write(content)
    file:close()
end

function M.add (body)
    local list = get_list()
    table.insert(list["todos"], body)
    save_list(list)
    return list
end

function M.rm (index)
    local list = get_list()
    table.remove(list["todos"], tonumber(index))
    save_list(list)
    return list
end

function M.list()
    return get_list()['todos']
end

return M
