local M = {}

local APPEND = -1
local OVERRIDE = 0

local function get_buf_by_name(bufName)
    for _, b in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_get_name(b):match(bufName) then
            return b
        end
    end
    return nil
end

local function get_win_by_buf(buf)
    if not buf then return end
    for _, w in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(w) == buf then
            return w
        end
    end
    return nil
end

local function create_window(buf, split, win, height)
    vim.api.nvim_open_win(buf, true, {
        split  = split,
        win    = win,
        height = height,
    })
end

local function create_buf(name)
    local buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_buf_set_name(buf, name)
    return buf
end

local function put_line_buf(buf, line, override)
    vim.api.nvim_buf_set_lines(buf, override, -1, false, { line })
    local lnb = vim.api.nvim_buf_line_count(buf)
    vim.fn.cursor(lnb, 0)
end

local function compile_mode_window()
    local buf_name = "Exec"
    local buf = get_buf_by_name(buf_name)
    local win = get_win_by_buf(buf)

    if buf then
        if not win then
            create_window(buf, "below", 0, 15)
        end
    else
        buf = create_buf(buf_name)
        create_window(buf, "below", 0, 15)
    end
    return buf
end

local function run_cmd(buf, cmd)
    put_line_buf(buf, "command: "..cmd, OVERRIDE)

    local function on_stdout(_, data)
        for _, line in ipairs(data) do
            if line ~= "" then
                put_line_buf(buf, line, APPEND)
            end
        end
    end

    vim.fn.jobstart(cmd, {
        stdout_buffered = false,
        on_stdout       = on_stdout,
        on_stderr       = on_stdout,
    })
end

local function exec(cmd)
    local buf = compile_mode_window()
    run_cmd(buf, cmd)
end

local function setup()
    vim.api.nvim_create_user_command("Exec", function(opts)
        local input = ""
        if #opts.args > 0 then
            input = opts.args
            exec(input)
        else
            print("exec mode: missing arguments")
        end
    end, { nargs = "*" })
end

vim.api.nvim_create_autocmd("VimEnter", {
    once     = true,
    callback = setup,
})

return M
