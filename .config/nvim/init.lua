local is_bootstrap = false
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
    vim.cmd "packadd packer.nvim"
end
if is_bootstrap then
    print "=================================="
    print "    Plugins are being installed"
    print "    Wait until Packer completes,"
    print "       then restart nvim"
    print "=================================="
    return
end

require "keymap"
require "options"
