-- helper to reload module

local usercmd = vim.api.nvim_create_user_command
local remove = require("plenary.reload").reload_module

usercmd("Reload", function(opts)
    remove(opts.fargs[1])
    require(opts.fargs[1])
end, { nargs = 1 })

usercmd("ReloadCurry", function(_)
    remove("curry")
    require("curry").setup()
end, {})
