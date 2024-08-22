local themes = {}

local function scriptPath()
   local str = debug.getinfo(2, "S").source:sub(2)
   return str:match("(.*/)")
end

-- loading all themes in this directory
local currentPath = scriptPath()
local theme_names = {}
local dirIter, dirObj = vim.loop.fs_scandir(currentPath)

while true do
    local name, type = vim.loop.fs_scandir_next(dirIter, dirObj)

    if name == nil then break end

    if type == "directory" then table.insert(theme_names, name) end
end

for _, theme in ipairs(theme_names) do
    table.insert(themes, require("plugins.themes." .. theme))
end

return themes
