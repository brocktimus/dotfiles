return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require('nvim-treesitter').install({
        -- Daily Drivers
        "ruby", "javascript", "typescript", "python", "php", "lua", "html", "css",
        -- Configs & Docs
        "markdown", "markdown_inline", "yaml", "json", "bash", "regex",
        -- Neovim Internals
        "vim", "vimdoc", "query"
    }):wait(300000) -- wait max. 5 minutes
  end,
}
