return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({
      -- Signs in the gutter (keep them simple)
      signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation: Jump between hunks
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gitsigns.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = "Next Hunk" })

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gitsigns.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = "Prev Hunk" })

        -- Actions: The "Senior" stuff
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "Stage Hunk" })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "Reset Hunk" })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "Preview Hunk" })
        map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, { desc = "Full Blame" })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = "Diff This" })
      end
    })
  end
}
