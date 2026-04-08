vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        -- vim.cmd("hi statusLine guibg=#7d88ad")
        vim.cmd("hi statusLine guibg=NONE")
    end,
})

-- vim.cmd("colorscheme vague")
vim.cmd("colorscheme custom")

-- For nvim default completion 
-- vim.opt.completeopt = { "menu", "menuone", "noinsert" }
-- vim.opt.complete = { ".", "w", "b", "u", "t", "i" }
-- vim.opt.path:append("**")
-- vim.o.autocomplete = false
--
-- vim.api.nvim_create_autocmd('LspAttach', {
--     group = vim.api.nvim_create_augroup('my.lsp', {}),
--     callback = function(args)
--         local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--
--         if client:supports_method('textDocument/completion') then
--             -- Optional: trigger autocompletion on EVERY keypress. May be slow!
--             local chars = {}; for i = 33, 126 do table.insert(chars, string.char(i)) end
--             client.server_capabilities.completionProvider.triggerCharacters = chars
--             vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
--         end
--     end,
-- })
--
-- vim.api.nvim_set_hl(0, 'Pmenu', { bg = '#000000', fg = '#d0d0d0' })
-- vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#ffffff', fg = '#000000' })
-- vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = '#000000' })
-- vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = '#000000' })
-- vim.api.nvim_set_hl(0, 'PmenuMatch', { bg = '#000000', fg = '#fabd2f', bold = true })
-- vim.api.nvim_set_hl(0, 'PmenuMatchSel', { bg = '#ffffff', fg = '#d79921', bold = true })
-- colors
vim.api.nvim_set_hl(0, 'BlinkCmpMenu', { bg = '#000000' })
vim.api.nvim_set_hl(0, 'BlinkCmpBorder', { bg = '#000000' })
vim.api.nvim_set_hl(0, 'BlinkCmpMenuSelection', { bg = '#7a7a78' })
vim.api.nvim_set_hl(0, 'BlinkCmpDoc', { bg = '#000000' })

local visual_event_group =
    vim.api.nvim_create_augroup("visual_event", { clear = true })

vim.api.nvim_create_autocmd("ModeChanged", {
    group = visual_event_group,
    pattern = { "*:[vV\x16]*" },
    callback = function()
        vim.opt.list = true
        vim.opt.listchars = {
            space = "•",
            tab = "→ ",
        }
    end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
    group = visual_event_group,
    pattern = { "[vV\x16]*:*" },
    callback = function()
        vim.opt.list = false
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove("r")
        vim.opt_local.formatoptions:remove("o")
    end,
})

