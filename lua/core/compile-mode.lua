local M = {}

local DATE_FMT = "%A %d %B %H:%M:%S"
local APPEND = -1
local OVERRIDE = 0

local COMPILE_STATE = {
    lastCmd   = "",
    nameSpace = vim.api.nvim_create_namespace("CompileModeNS")
}

local function set_highlights()
    vim.api.nvim_set_hl(0, 'CompilationGreen', { fg = '#73d936', bg = nil })
    vim.api.nvim_set_hl(0, 'CompilationRed', { fg = '#f43841', bg = nil })
    vim.api.nvim_set_hl(0, 'CompilationERROR', { fg = '#f43841', bg = nil, underline = true })
    vim.api.nvim_set_hl(0, 'CompilationYellow', { fg = '#ffdd33', bg = nil })
    vim.api.nvim_set_hl(0, 'CompilationWARNING', { fg = '#cc8c3c', bg = nil, underline = true })
    vim.api.nvim_set_hl(0, 'CompilationNOTE', { fg = '#96a6c8', bg = nil, underline = true })
end

local SIGNALS = {
    [1]  = "sighup",
    [2]  = "sigint",
    [3]  = "sigquit (core dumped)",
    [4]  = "sigill (core dumped)",
    [6]  = "sigabrt (core dumped)",
    [7]  = "sigbus (core dumped)",
    [8]  = "sigfpe (core dumped)",
    [9]  = "sigkill",
    [11] = "sigsegv (core dumped)",
    [13] = "sigpipe",
    [15] = "sigterm",
    [24] = "sigxcpu",
    [25] = "sigxfsz",
}

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

local function pattern_hl(buf, str, pattern, hl_group)
    local start, end_ = str:lower():find(pattern:lower())
    local lnum = vim.api.nvim_buf_line_count(buf) - 1
    if not start then return end
    vim.api.nvim_buf_set_extmark(buf, COMPILE_STATE.nameSpace, lnum, start - 1, {
        end_col  = end_,
        hl_group = hl_group,
    })
end

local function index_hl(buf, s, e, hl_group)
    local lnum = vim.api.nvim_buf_line_count(buf) - 1
    vim.api.nvim_buf_set_extmark(buf, COMPILE_STATE.nameSpace, lnum, s, {
        end_col  = e,
        hl_group = hl_group,
    })
end

local function compile_mode_window()
    local buf_name = "Compile Mode"
    local buf = get_buf_by_name(buf_name)
    local win = get_win_by_buf(buf)
    local compmsg = "Compilation started at " .. os.date(DATE_FMT)

    if buf then
        if not win then
            create_window(buf, "below", 0, 15)
        end
    else
        buf = create_buf(buf_name)
        create_window(buf, "below", 0, 15)
    end
    put_line_buf(buf, compmsg, OVERRIDE)
    pattern_hl(buf, compmsg, "started", "CompilationGreen")
    put_line_buf(buf, "", APPEND)
    return buf
end

local function run_cmd(buf, cmd)
    put_line_buf(buf, cmd, APPEND)
    index_hl(buf, 0, #cmd, "CompilationNOTE")
    put_line_buf(buf, "", APPEND)

    local function on_stdout(_, data)
        for _, line in ipairs(data) do
            if line ~= "" then
                put_line_buf(buf, line, APPEND)
                pattern_hl(buf, line, "error", "CompilationERROR")
                pattern_hl(buf, line, "***", "CompilationERROR")
                pattern_hl(buf, line, "warning", "CompilationWARNING")
                pattern_hl(buf, line, "note", "CompilationNOTE")
            end
        end
    end

    local function on_exit(_, code, event)
        put_line_buf(buf, "", APPEND)
        local signal_code = (code > 128) and (code - 128) or nil

        if event == "signal" or signal_code then
            local sig_num = signal_code or code
            local sig     = SIGNALS[sig_num]
            local msg     = "Compilation terminated by " .. sig .. " at " .. os.date(DATE_FMT)
            put_line_buf(buf, msg, APPEND)
            pattern_hl(buf, msg, "terminated", "CompilationRed")
            pattern_hl(buf, msg, "sigsegv", "CompilationRed")
            pattern_hl(buf, msg, "core dumped", "CompilationRed")
        elseif code == 0 then
            local msg = "Compilation finished at " .. os.date(DATE_FMT)
            put_line_buf(buf, msg, APPEND)
            pattern_hl(buf, msg, "finished", "CompilationGreen")
        else
            local msg      = "Compilation exited abnormally with code "
            local msg_code = tostring(code) .. " at " .. os.date(DATE_FMT)
            put_line_buf(buf, msg .. msg_code, APPEND)
            pattern_hl(buf, msg .. msg_code, "exited abnormally", "CompilationRed")
            index_hl(buf, #msg, #msg + #tostring(code), "CompilationRed")
        end
    end

    vim.fn.jobstart(cmd, {
        stdout_buffered = false,
        on_stdout       = on_stdout,
        on_stderr       = on_stdout,
        on_exit         = on_exit,
    })
end

local function compile_mode(cmd)
    if (#cmd <= 0) then
        print("compile command: missing arguments")
    else
        local buf = compile_mode_window()
        run_cmd(buf, cmd)
    end
end

local function setup()
    set_highlights()
    vim.api.nvim_create_user_command("CompileCommand", function(opts)
        local input = ""
        if #opts.args > 0 then
            input = opts.args
            COMPILE_STATE.lastCmd = opts.args
            compile_mode(input)
        else
            input = COMPILE_STATE.lastCmd
            if not input then return end
            compile_mode(input)
        end
    end, { nargs = "*" })
end

vim.api.nvim_create_autocmd("VimEnter", {
    once     = true,
    callback = setup,
})

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = set_highlights,
})

return M
