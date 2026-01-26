return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      -- Languages you want pre-installed via your install.sh
      ensure_installed = {
        -- Daily Drivers
        "ruby", "javascript", "typescript", "python", "php", "lua", "html", "css",
        -- Configs & Docs
        "markdown", "markdown_inline", "yaml", "json", "bash", "regex",
        -- Neovim Internals
        "vim", "vimdoc", "query"
      },
      
      -- Install parsers synchronously (better for your install.sh)
      sync_install = true,
      
      -- Automatically install missing parsers when you enter a new filetype
      auto_install = true,

      highlight = {
        enable = true,
        -- Disable standard vim regex highlighting for better performance
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true,
      },

      -- The "Power User" feature:
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",   -- Start selecting with Enter
          node_incremental = "<CR>", -- Expand selection to the next "node"
          node_decremental = "<BS>",    -- Shrink selection with Backspace
	  scope_incremental = false,    -- Prevent "Big Jump" logic
        },
      },
    })
  end,
}
