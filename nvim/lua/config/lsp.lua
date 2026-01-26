local lspconfig = require('lspconfig')

local lspconfig = require('lspconfig')
local fzf = require('fzf-lua')

-- Handshake: Tells the LSP that we can handle fuzzy-finder features
local capabilities = fzf.get_lsp_capabilities()

-- On Attach: This function runs ONLY when an LSP connects to a file
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr }

    -- Navigation (Mapped to FZF)
    vim.keymap.set('n', 'gd', fzf.lsp_definitions, opts)
    vim.keymap.set('n', 'gr', fzf.lsp_references, opts)
    vim.keymap.set('n', ';ds', fzf.lsp_document_symbols, opts)
    vim.keymap.set('n', ';ca', fzf.lsp_code_actions, opts)
    
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
    lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end
