return {
  'neovim/nvim-lspconfig',
  dependencies = { 'ibhagwan/fzf-lua' },
  config = function()
    -- This calls the file we discussed earlier: lua/config/lsp.lua
    require('config.lsp')
  end
}
