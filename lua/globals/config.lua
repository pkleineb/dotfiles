local module = {}

module.options = {    
    autoindent = true,
}

module.autocmd = {
    {
        event = "FileType",
        patterns = { "make" },
        command = "set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab",
    }
}

module.setup = function()
    for option, value in pairs(module.options) do
        vim.opt[option] = value
    end

    local exclude_file_types = "NvimTree,"
    for _, autocmd in ipairs(module.autocmd) do
        local cmd = string.format("autocmd %s %s %s", autocmd.event, table.concat(autocmd.patterns, ","), autocmd.command)
        exclude_file_types = exclude_file_types .. table.concat(autocmd.patterns, ",")
        vim.cmd(cmd)
    end

    local default_tab_cmd = "autocmd FileType * if &ft !~# '" .. exclude_file_types .. "' | set tabstop=4 shiftwidth=4 softtabstop=4 expandtab"
    vim.cmd(default_tab_cmd)

    local default_file_explorer = "NvimTreeOpen"
    vim.cmd("autocmd VimEnter * " .. default_file_explorer)

end

return module
