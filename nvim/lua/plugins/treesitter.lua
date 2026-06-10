--return {
--  "nvim-treesitter/nvim-treesitter",
--  lazy = false,
--  build = ":TSUpdate",
--  config = function()
--    require('nvim-treesitter').install({
--        -- Daily Drivers
--        "ruby", "javascript", "typescript", "python", "php", "lua", "html", "css",
--        -- Configs & Docs
--        "markdown", "markdown_inline", "yaml", "json", "bash", "regex",
--        -- Neovim Internals
--        "vim", "vimdoc", "query"
--    }):wait(300000) -- wait max. 5 minutes
--  end,
--}

--return {
--  "nvim-treesitter/nvim-treesitter",
--  lazy = false,
--  -- Pass the languages directly to the shell command or the build function
--  build = function()
--    require("nvim-treesitter").install({
--      -- Daily Drivers
--      "ruby", "javascript", "typescript", "python", "php", "lua", "html", "css",
--      -- Configs & Docs
--      "markdown", "markdown_inline", "yaml", "json", "bash", "regex",
--      -- Neovim Internals
--      "vim", "vimdoc", "query"
--    }):wait(300000)
--  end,
--  config = function()
--    -- Only handle runtime initialization here, no install logic
--    require('nvim-treesitter').setup()
--  end,
--}

return {
  "romus204/tree-sitter-manager.nvim",
  dependencies = {}, -- tree-sitter CLI must be installed system-wide
  config = function()
    require("tree-sitter-manager").setup({
      auto_install = true,
    })
  end
}
