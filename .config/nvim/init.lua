local function bootstrap(url, ref)
    local name = url:gsub(".*/", "")
    local path

    path = vim.fn.stdpath "data" .. "/lazy/" .. name
    vim.opt.runtimepath:prepend(path)

    if vim.fn.isdirectory(path) == 0 then
        print(name .. ": installing in data dir...")

        vim.fn.system { "git", "clone", url, path }
        if ref then
            vim.fn.system { "git", "-C", path, "checkout", ref }
        end

        vim.cmd "redraw"
        print(name .. ": finished installing")
    end
end
bootstrap("https://github.com/udayvir-singh/tangerine.nvim", "v2.8")
bootstrap "https://github.com/udayvir-singh/hibiscus.nvim"

require "tangerine".setup {
    target = vim.fn.stdpath [[data]] .. "/tangerine",
    compiler = {
        verbose = false,
        hooks = { "oninit", "onsave" },
    },
}
