local lsps = {
    'omnisharp',
    'clangd',
    'hls',
    'pyright',
    'lua_ls',
    'asm_lsp',
    'cmake',
    'zls',
    'cssls',
    'html',
    'rust_analyzer',
    'bashls',
    'yamlls',
    'jdtls'
}

vim.lsp.enable(lsps)

require("mason-lspconfig").setup({
    ensure_installed = lsps,
})
