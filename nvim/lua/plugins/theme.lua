return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      transparent = false, -- Hard no.
      italic_comments = true,
      hide_fillchars = true,
      borderless_pickers = true,
    })
    vim.cmd("colorscheme cyberdream")
  end,
}
