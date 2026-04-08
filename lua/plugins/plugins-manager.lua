vim.pack.add({
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/ellisonleao/gruvbox.nvim" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/Saghen/blink.cmp" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/Shatur/neovim-ayu" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
    { src = "https://github.com/MunifTanjim/nui.nvim" },
    { src = "https://github.com/akinsho/bufferline.nvim" },
})

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
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls" }
})
require "nvim-web-devicons".setup()
require("luasnip.loaders.from_vscode").lazy_load()

require("plugins.blink")
require("plugins.lsp")
require("plugins.treesiter")
require("plugins.telescope")
require("plugins.oil")
require("plugins.colors")
