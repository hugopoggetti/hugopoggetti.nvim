local vo = vim.opt

vim.g.mapleader = " "
vo.number = true
vo.relativenumber = true
vo.signcolumn = "yes"
vo.termguicolors = true
vo.wrap = false
vo.tabstop = 4
vo.swapfile = false
vo.winborder = "rounded"
vo.clipboard = "unnamedplus"
vo.undofile = true
vo.incsearch= true
vo.tabstop = 4
vo.shiftwidth = 4
vo.expandtab = true
vo.guicursor = ""
vim.opt.smoothscroll = true
vim.opt.grepprg = "rg --vimgrep --no-messages --smart-case"
-- vim.opt.statusline = " [%n] %<%f %h%w%m%r%=%-14.(%l,%c%V%) %P "

-- diagnostic config
vim.diagnostic.config({
    virtual_text = true,
    -- virtual_lines = { current_line = true },
    underline = true,
    update_in_insert = false
})
