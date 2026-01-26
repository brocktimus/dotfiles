return {
  'neovim/nvim-lspconfig',
  version = 'v2.5.0',
  dependencies = { 'ibhagwan/fzf-lua' },
  config = function()
    -- This calls the file we discussed earlier: lua/config/lsp.lua
    require('config.lsp')
  end
}
