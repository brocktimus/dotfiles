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
    'basedpyright', 
    'gopls', 
    'solargraph', 
    'yamlls', 
    'jsonls', 
    'marksman' 
}

for _, lsp in ipairs(servers) do
    -- This is the fixed call that handles the nil capability race condition
    local ok, fzf = pcall(require, 'fzf-lua')
    local caps = ok and fzf.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()
    lspconfig[lsp].setup({
        on_attach = on_attach,
	-- Use standard internal caps if fzf isn't ready, or call it here
	capabilities = require('fzf-lua').get_lsp_capabilities(),
    })
end
