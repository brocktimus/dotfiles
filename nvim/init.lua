-- nvim/init.lua

-- 1. Load your basic settings
require("config.options")
require("config.keymaps")
require("config.filetypes")

-- 2. Bootstrap Lazy.nvim (the manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- 3. The magic line: it tells Lazy to look in lua/plugins/
require("lazy").setup({
  spec = {
    -- your plugin imports or specs here
    { import = "plugins" },
  },
  -- Disable the background disk polling for config changes
  change_detection = {
    enabled = false,
    notify = false, -- No "Config Change Detected" popups
  },
})

require("config.lsp")
