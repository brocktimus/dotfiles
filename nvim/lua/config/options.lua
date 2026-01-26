local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & Indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Performance & Feel
opt.termguicolors = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300
opt.scrolloff = 8 -- Keep 8 lines above/below cursor
opt.mouse = "a"

-- Backup/Swap (Keep the directory clean)
opt.backup = false
opt.writebackup = false
opt.swapfile = false
