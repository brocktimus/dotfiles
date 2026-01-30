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

keymap('n', '<leader>ff', ':FzfLua files<CR>', { noremap = true, silent = true, desc = "Find Files" })
keymap('n', '<leader>fg', ':FzfLua live_grep<CR>', { noremap = true, silent = true, desc = "Live Grep" })
keymap('n', '<leader>fb', ':FzfLua buffers<CR>', { noremap = true, silent = true, desc = "List Buffers" })
keymap('n', '<leader>fh', ':FzfLua help_tags<CR>', { noremap = true, silent = true, desc = "Help Tags" })

-- FZF Useful Stuff
keymap("n", "<leader>sw", "<cmd>FzfLua grep_cword<cr>", { desc = "Grep Word Under Cursor" })
keymap("n", "<leader>sd", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "Document Symbols" })
keymap("n", "<leader>sr", "<cmd>FzfLua resume<cr>", { desc = "Resume Last Search" })
keymap("n", "<leader>gs", "<cmd>FzfLua git_status<cr>", { desc = "Git Status" })
keymap("n", ";t", "<cmd>TodoFzfLua<cr>", { desc = "Fuzzy find TODOs" })

-- Escape Terminal Mode easily to start searching/scrolling
-- This lets you use '/' immediately to find your failure
keymap('t', '<Esc>', [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })

-- Show the error/warning message in a floating window (The one you asked for)
keymap('n', 'gl', vim.diagnostic.open_float)

-- Jump between diagnostics
keymap('n', '[d', vim.diagnostic.goto_prev)
keymap('n', ']d', vim.diagnostic.goto_next)

-- Dump everything into the Quickfix list (Project-wide view)
keymap('n', '<leader>dl', vim.diagnostic.setqflist)

-- Toggle LSP diagnostics
keymap('n', '<leader>dn', function()
    local is_on = vim.diagnostic.config().virtual_text
    vim.diagnostic.config({
        virtual_text = not is_on,
        signs = not is_on,
        underline = not is_on,
    })
    print("Diagnostics: " .. (not is_on and "ON" or "OFF"))
end, { desc = "Toggle Diagnostics" })

keymap('n', '<leader>tf', function()
    local file = vim.fn.expand("%:p")

    -- Only run if it's a PHP file within a 'tests' folder
    if file:match("tests/.*%.php$") then
        -- Close existing terminal windows to prevent clutter
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == "terminal" then
                vim.api.nvim_win_close(win, true)
            end
        end

        -- Use vim.cmd to execute the sequence
        vim.cmd("botright 15split")
        vim.cmd("term ./vendor/bin/pest " .. file)
        -- This jumps back to the code window
        vim.cmd("wincmd p")
    else
        print("Not a valid Pest test file.")
    end
end, { desc = "Run Pest on current file" })
