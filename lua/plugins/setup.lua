require("mason").setup()
require("bufferline").setup({
    options = {
        mode = "tabs",
    }
})
require("neo-tree").setup({
    enable_diagnostics = false,
    enable_git_status = false,
    window = {
        width = 28,
    },
})
require("nvim-web-devicons").setup()
require("luasnip.loaders.from_vscode").lazy_load()
require("plugins.blink")
require("plugins.lsp")
require("plugins.treesiter")
require("plugins.telescope")
require("plugins.oil")
require("plugins.colors")
