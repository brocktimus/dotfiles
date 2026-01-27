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

-- Your Arrow Key "Tough Love"
local modes = { "n", "i", "v" }
for _, mode in ipairs(modes) do
  keymap(mode, "<Left>",  function() print("No left for you!") end)
  keymap(mode, "<Right>", function() print("No right for you!") end)
  keymap(mode, "<Up>",    function() print("No up for you!") end)
  keymap(mode, "<Down>",  function() print("No down for you!") end)
end

-- Quick Save
keymap("n", "<leader>s", "<cmd>update<cr>", { desc = "Save if modified" })

-- FZF Basics
keymap("n", ";f", "<cmd>FzfLua files<cr>", { desc = "Fzf Files" })
keymap("n", "<leader>sg", "<cmd>FzfLua live_grep<cr>", { desc = "Grep Project" })

-- FZF Useful Stuff
keymap("n", "<leader>sw", "<cmd>FzfLua grep_cword<cr>", { desc = "Grep Word Under Cursor" })
keymap("n", "<leader>sd", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "Document Symbols" })
keymap("n", "<leader>sr", "<cmd>FzfLua resume<cr>", { desc = "Resume Last Search" })
keymap("n", "<leader>gs", "<cmd>FzfLua git_status<cr>", { desc = "Git Status" })
keymap("n", ";t", "<cmd>TodoFzfLua<cr>", { desc = "Fuzzy find TODOs" })

-- Run the tests
keymap('n', '<leader>tn', ":TestNearest<CR>", { desc = "Test Nearest" })
keymap('n', '<leader>tf', ":TestFile<CR>",    { desc = "Test File" })

-- Toggle the terminal split (if you want to hide/show it)
-- Note: This assumes the terminal is the only other window.
keymap('n', '<leader>tt', function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].buftype == "terminal" then
            vim.api.nvim_win_close(win, true)
            return
        end
    end
    print("No test terminal open")
end, { desc = "Close Test Terminal" })

-- Escape Terminal Mode easily to start searching/scrolling
-- This lets you use '/' immediately to find your failure
keymap('t', '<Esc>', [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })
