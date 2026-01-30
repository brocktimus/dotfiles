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
opt.smartindent = false

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
opt.mouse = ""

-- Backup/Swap (Keep the directory clean)
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- The "Don't Break Things" Clipboard
-- Do NOT set clipboard = "unnamedplus" globally. 
-- It adds ~50-100ms latency on every yank/delete in remote envs.

-- Netrw settings
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- Folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99 -- Don't start with everything closed!
vim.opt.foldlevelstart = 99
vim.opt.foldtext = ""

-- Wrap
vim.opt.wrap = true            -- Enable wrapping
vim.opt.breakindent = true     -- Wrapped lines keep the same indentation level
vim.opt.linebreak = true       -- Don't break words in the middle
vim.opt.showbreak = "↳ "       -- Visual cue at the start of wrapped lines

-- Highlighting
vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})

-- LSP
vim.diagnostic.config({
  virtual_text = false,
  signs = false,
  underline = false,
})
