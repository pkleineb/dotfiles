local M = {}

function M.reloadLua(fileName)
    local relativePath = fileName:gsub(vim.fn.getcwd() .. "/", "")
    relativePath = relativePath:gsub("%.[^.]+$", "")
    local moduleName = relativePath:gsub("[^%w]", ".")

    package.loaded[moduleName] = nil
    require(moduleName)
end

function M.loadDir(dirPath)
    local dirEntrys = vim.split(vim.fn.glob(dirPath .. "/*"), "\n", {timempty=true})

    for _, entry in pairs(dirEntrys) do
        if vim.fn.isdirectory(entry) == 1 then
            M.loadDir(entry)
        elseif vim.fn.filereadable(entry) == 1 then
            M.reloadLua(entry)
        end
    end

end

return M
