local configs = require('lspconfig.configs')
local lspconfig = require('lspconfig')

-- On Attach: This function runs ONLY when an LSP connects to a file
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr }
    -- Use pcall here to be absolutely safe during startup
    local ok, fzf = pcall(require, 'fzf-lua')

    -- Navigation (Mapped to FZF)
    if ok then
        vim.keymap.set('n', 'gd', fzf.lsp_definitions, opts)
        vim.keymap.set('n', 'gr', fzf.lsp_references, opts)
        vim.keymap.set('n', ';ds', fzf.lsp_document_symbols, opts)
        vim.keymap.set('n', ';ca', fzf.lsp_code_actions, opts)
    end
    
    -- Basic LSP (Standard Neovim UI)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
end

-- Explicit list of servers you've installed in your Dockerfile
-- If a binary isn't in your $PATH, it just won't start (no crash)
local servers = { 
    'phpactor', 
    'basedpyright', 
    'basedpyright', 
    'solargraph', 
    'yamlls', 
    'jsonls', 
    'gopls', 
    'marksman',
}

-- Use standard Neovim capabilities. 
-- FZF-lua doesn't actually 'add' capabilities; it just formats the results.
local caps = vim.lsp.protocol.make_client_capabilities()

for _, lsp in ipairs(servers) do
  local cfg = lspconfig[lsp]
  local cmd = cfg.document_config.default_config.cmd[1]

  -- ONLY setup if the binary exists in the Docker container's PATH
  if vim.fn.executable(cmd) == 1 then
    lspconfig[lsp].setup({
      on_attach = on_attach,
      capabilities = caps,
    })
  end
end
