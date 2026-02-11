return {
  "sainnhe/gruvbox-material",
  --"folke/tokyonight.nvim",
  --"rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- Essential for screensharing contrast
    vim.g.gruvbox_material_background = 'hard'
    vim.g.gruvbox_material_foreground = 'material'
    vim.g.gruvbox_material_ui_contrast = 'high'
    
    -- Fixes muddy colors in tmux
    vim.g.gruvbox_material_enable_bold = 1
    vim.g.gruvbox_material_better_performance = 1
    
    -- Load the theme
    vim.cmd.colorscheme("gruvbox-material")
    --vim.cmd.colorscheme("tokyonight-night")
    --vim.cmd.colorscheme("kanagawa")
    --vim.cmd.colorscheme("kanagawa-wave")
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
    vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#32302f' })
    -- vim.api.nvim_set_hl(0, 'ColorColumn', { link = 'CursorLine' })
  end,
}
