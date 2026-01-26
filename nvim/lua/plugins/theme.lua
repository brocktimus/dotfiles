return {
  "sainnhe/gruvbox-material",
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
  end,
}
