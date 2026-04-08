local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        preview = {
            hide_on_startup = true
        },
        color_devicons = true,
        sorting_strategy = "ascending",
        path_display = { "smart" },
        layout_config = {
            height = function() return math.floor(0.7 * vim.o.lines) end,
            width = function() return math.floor(0.7 * vim.o.columns) end,
            prompt_position = "top",
            preview_width = 0.7,
        },
        mappings = {
            i = {
                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,
                ["<CR>"] = function(prompt_bufnr)
                    actions.select_default(prompt_bufnr)
                    vim.cmd("normal! zz")
                end,

                ["<C-y>"] = function(prompt_bufnr)
                    actions.select_default(prompt_bufnr)
                    vim.cmd("normal! zz")
                end,
                ['<Tab>'] = require('telescope.actions.layout').toggle_preview,
                ["<esc>"] = require('telescope.actions').close,
            },
            n = {
                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,
                ["<C-y>"] = function(prompt_bufnr)
                    actions.select_default(prompt_bufnr)
                    vim.cmd("normal! zz")
                end,
                ["<CR>"] = function(prompt_bufnr)
                    actions.select_default(prompt_bufnr)
                    vim.cmd("normal! zz")
                end,
                ['<Tab>'] = require('telescope.actions.layout').toggle_preview,
            },
        },
    },
    pickers = {
        find_files = {
            hidden = true,
            find_command = { "fd", "--type", "f", "--color", "never", "--hidden", "--exclude", ".git" }
        },
    },
})
