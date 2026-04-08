require "blink.cmp".setup({
    snippets = { preset = 'luasnip' },
    keymap = { preset = 'default' },
    cmdline = { enabled = false },
    completion = {
        keyword = { range = 'full' },
        accept = { auto_brackets = { enabled = false }, },
        list = { selection = { preselect = false, auto_insert = false } },
        menu = {
            auto_show = true,
            winblend = 0,
            scrollbar = false,
            -- border = 'single',
            border = 'none',
            draw = {
                padding = { 1, 2 },
                treesitter = { "lsp" },
                columns = {
                    { "label",     "label_description", gap = 1 },
                    { "kind" }
                },
            },
        },
        documentation = { auto_show = false, window = { winblend = 0 }, },
        ghost_text = { enabled = true },
    },
    appearance = {
        nerd_font_variant = "mono",
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        -- path = {
        --     opts = {
        --         get_cwd = function(_)
        --             return vim.fn.getcwd()
        --         end,
        --     }
        -- },
    },
    signature = { enabled = true }
})

