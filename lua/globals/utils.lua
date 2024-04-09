local M = {}

function M.reloadLua(fileName)
    local relativePath = fileName:gsub(vim.fn.getcwd() .. "/", "")
    relativePath = relativePath:gsub("%.[^.]+$", "")
    local moduleName = relativePath:gsub("[^%w]", ".")
    print(moduleName)

    package.loaded[moduleName] = nil
    require(moduleName)

    print("reloaded " .. moduleName)
end

return M
