local keymap = vim.keymap.set

-- Set leader to space (matches your modern preference)
vim.g.mapleader = " "

-- Better window navigation (if not using C-h/j/k/l tmux-nav)
-- keymap("n", "<C-h>", "<C-w>h")

-- Resizing panes
keymap("n", "<C-Up>", ":resize +2<CR>")
keymap("n", "<C-Down>", ":resize -2<CR>")
keymap("n", "<C-Left>", ":vertical resize -2<CR>")
keymap("n", "<C-Right>", ":vertical resize +2<CR>")

-- Visual Mode: Move blocks of text
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in place when joining lines
keymap("n", "J", "mzJ`z")

-- Keep search results centered
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Fast exit to netrw (file explorer)
keymap("n", "<leader>pv", vim.cmd.Ex)

-- Your Arrow Key "Tough Love" (If you still want it)
local modes = { "n", "i", "v" }
for _, mode in ipairs(modes) do
  keymap(mode, "<Left>",  function() print("No left for you!") end)
  keymap(mode, "<Right>", function() print("No right for you!") end)
  keymap(mode, "<Up>",    function() print("No up for you!") end)
  keymap(mode, "<Down>",  function() print("No down for you!") end)
end

-- Quick Save
keymap("n", "<leader>s", "<cmd>update<cr>", { desc = "Save if modified" })

-- Treesitter START --
-- Start/Expand selection
vim.keymap.set({ "n", "x" }, "<CR>", function()
  if vim.fn.mode() == "n" then
    -- Initialize selection
    require("nvim-treesitter.incremental_selection").init_selection()
  else
    -- Incremental expand
    require("nvim-treesitter.incremental_selection").node_incremental()
  end
end, { desc = "TS Incremental Expand" })

-- Shrink selection
vim.keymap.set("x", "<BS>", function()
  require("nvim-treesitter.incremental_selection").node_decremental()
end, { desc = "TS Incremental Shrink" })
-- Treesitter END --
