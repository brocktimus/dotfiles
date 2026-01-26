return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",      -- The engine
    "saadparwaiz1/cmp_luasnip", -- The bridge
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- This is the "magic" bridge line
        end,
      },
      mapping = cmp.mapping.preset.insert({
        -- Navigating the menu
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        
        -- Scrolling documentation
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),

        -- Confirming & Closing
        ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Explicit YES
        ['<C-e>'] = cmp.mapping.abort(),                    -- Get out of my face

        -- Enter key logic: Only confirm IF an item is manually selected
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false, 
        }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- Add this to the list
        { name = 'buffer' },
        { name = 'path' },
      })
    })
  end,
}
