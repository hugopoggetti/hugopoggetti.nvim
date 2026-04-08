local map = vim.keymap.set

map({ "s", "n", "v", "x" }, '<leader>o', '<cmd>source<cr>')
map({ "s", "n", "v", "x" }, '<leader>w', '<cmd>write<cr>')
map({ "s", "n", "v", "x" }, '<leader>q', '<cmd>quit<cr>')
map({ "s", "n", "v", "x" }, '<leader>Q', '<cmd>wqa<cr>')

map({ "s", "n", "v", "x" }, '<leader>v', '<cmd>vertical split #<cr>')
map("t", '<esc><esc>', '<c-\\><c-n>')

map({ 'n', 'v', 'x' }, '<leader>y', '"+y<cr>')
map({ "n", "v" }, "<leader>d", [["_d]])

-- Keeping the cursor centered.
map("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
map("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Escape and save changes.
map({ "s", "i", "n", "v" }, "<C-s>", "<esc><cmd>w<cr>", { desc = "Exit insert mode and save changes." })

-- Indent lines and keep selection
map("v", ">", ">gv", { noremap = true, silent = true })
map("v", "<", "<gv", { noremap = true, silent = true })

-- Move lines in visual
map("n", "<C-j>", "<cmd>move .+1<CR>==", { noremap = true, silent = true })
map("n", "<C-k>", "<cmd>move .-2<CR>==", { noremap = true, silent = true })
map("v", "<C-j>", ":move '>+1<CR>gv=gv", { noremap = true, silent = true })
map("v", "<C-k>", ":move '<-2<CR>gv=gv", { noremap = true, silent = true })

-- add semocolon at the end of a line
map({ "s", "n", "v", "x" }, "<leader>;", "A;<Esc>", { noremap = true, silent = true })
-- highlight the current word on
map({ "s", "n", "v", "x" }, "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- jump to pairs file
map({ "s", "n", "v", "x" }, "<leader>h", "<cmd>lua require('core.jump').jump_pair()<cr>",
    { noremap = true, silent = true })
-- HTML format
map({ "s", "n", "v" }, "<leader>tt", "<cmd>s/<[^>]*>/\r&\r/g<cr><cmd>g/^$/d<cr>gg=G", { noremap = true, silent = true })

for i = 1, 8 do
    map({ "n", "t" }, "<Leader>" .. i, "<Cmd>tabn " .. i .. "<cr>")
end

-- resize vim windows
map({ "n", "v" }, "<leader>l", "<cmd>vertical resize +5<cr>")
map({ "n", "v" }, "<leader>L", "<cmd>vertical resize -5<cr>")
map({ "n", "v" }, "<leader>k", "<cmd>resize +5<cr>")
map({ "n", "v" }, "<leader>K", "<cmd>resize -5<cr>")

-- plugins
map({ "s", "n", "v", "x" }, '<leader>f', "<cmd>Telescope find_files<cr>")
map({ "s", "n", "v", "x" }, '<leader>b', "<cmd>Telescope buffers<cr>")
map({ "s", "n", "v", "x" }, '<leader>g', "<cmd>Telescope live_grep<cr>")
map({ "s", "n", "v", "x" }, '<leader>gs', "<cmd>Telescope grep_string<cr>")
map({ "s", "n", "v", "x" }, '<leader>bf', "<cmd>Telescope current_buffer_fuzzy_find<cr>")
map({ "s", "n", "v", "x" }, '<leader>lr', "<cmd>Telescope lsp_references<cr>")
map({ "s", "n", "v", "x" }, '<leader>ic', "<cmd>Telescope lsp_incoming_calls<cr>")
map({ "s", "n", "v", "x" }, '<leader>oc', "<cmd>Telescope lsp_outgoing_calls<cr>")
map({ "s", "n", "v", "x" }, '<leader>m', "<cmd>Telescope man_pages<cr>")
map({ "s", "n", "v", "x" }, '<leader>tt', "<cmd>Gitsigns toggle_signs<cr>")
map({ "s", "n", "v", "x" }, '<leader>e', "<cmd>Oil .<cr>")
map({ "s", "n", "v", "x" }, '<leader>E', "<cmd>Oil<cr>")
map({ "s", "n", "v", "x" }, '<leader>b', "<cmd>Neotree toggle<cr>")
map({ "s", "n", "v", "x" }, '<leader>c', ":CompileCommand")

-- lsp keymaps
map('n', '<leader>lf', vim.lsp.buf.format)
map('n', 'gd', "<cmd>Telescope lsp_definitions<cr>")
map('n', 'gri', "<cmd>Telescope lsp_implementations<cr>")
