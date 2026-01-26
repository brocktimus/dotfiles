local lspconfig = require('lspconfig')

-- On Attach: This function runs ONLY when an LSP connects to a file
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr }
    local fzf = require('fzf-lua')

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
	-- Use standard internal caps if fzf isn't ready, or call it here
	capabilities = require('fzf-lua').get_lsp_capabilities(),
    })
end
