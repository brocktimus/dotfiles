local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true
opt.cursorline = true        -- Horizontal highlight
opt.laststatus = 3           -- Global statusline (modern Neovim)

-- Tabs & Indent
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false         -- Don't stay yellow after search is done

-- Performance & Feel
opt.signcolumn = "yes"       -- Prevent text "jumping" when LSP/Git loads
opt.termguicolors = true     -- 24-bit RGB
opt.updatetime = 250
opt.timeoutlen = 300
opt.scrolloff = 8 -- Keep 8 lines above/below cursor
opt.mouse = "a"

-- Backup/Swap (Keep the directory clean)
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- The "Don't Break Things" Clipboard
-- Do NOT set clipboard = "unnamedplus" globally. 
-- It adds ~50-100ms latency on every yank/delete in remote envs.
