return {
  'saghen/blink.cmp',
  version = '*', -- Use a release tag to download pre-built binaries
  opts = {
    -- 1. NO NOISE: Kill the ghost text and snippet clutter
    appearance = {
      highlight_ns = vim.api.nvim_create_namespace('blink_cmp'),
    },
    sources = {
      -- We remove 'snippets' from the default list to keep the menu clean
      default = { 'lsp', 'path', 'buffer' },
    },

    -- 2. KEYMAPS: Your "Senior" Manual Logic
    keymap = {
      preset = 'none', -- Disable defaults so they don't fight you
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide' },
      ['<C-y>'] = { 'select_and_accept' }, -- Explicit YES

      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },

      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

      -- Enter only confirms if you've manually selected an item
      ['<CR>'] = { 'accept', 'fallback' },
    },

    -- 3. BEHAVIOR: No pre-selection, no jumping
    completion = {
      list = {
        selection = {
          preselect = false,   -- Don't highlight the first item automatically
          auto_insert = false, -- Don't insert text until you confirm
        }
      },
      menu = {
        auto_show = true,      -- Pop up while typing, but preselect=false keeps it quiet
      },
      ghost_text = { enabled = false }, -- No VS Code-style "shadow" text
    },

    -- Optional: If you hate the signature help (parameter popups), disable it here
    signature = { enabled = false },
  },
}
