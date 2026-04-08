local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- diagnostic config
vim.diagnostic.config({
    virtual_text = true,
    -- virtual_lines = { current_line = true },
    underline = true,
    update_in_insert = false
})

vim.lsp.enable({ 'omnisharp' ,'clangd', 'hls', 'pyright', 'lua_ls', 'asm_lsp', 'cmake', 'zls', 'cssls', 'html', 'rust_analyzer',
    'bashls', 'yamlls' })

vim.lsp.config["omnisharp"] = {
    capabilities = capabilities,
    cmd = { "OmniSharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
    settings = {
        omnisharp = {
            useModernNet = true,
            enableRoslynAnalyzers = true,
            enableEditorConfigSupport = true,
            organizeImportsOnFormat = true,
        },
    },
}

-- clangd
vim.lsp.config["clangd"] = {
    cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
    capabilities = capabilities,
}

-- Haskell
-- -- this save my life: https://github.com/haskell/haskell-language-server/issues/4493
-- -- ghcup compile hls --ghc 9.8.4 --git-ref master
vim.lsp.config['hls'] = {
    cmd = { "haskell-language-server-wrapper", "--lsp" },
    filetypes = { "haskell", "lhaskell" },
    root_markers = { "stack.yaml", "cabal.config", ".git" },
    capabilities = capabilities,
}

-- Pyright
vim.lsp.config["pyright"] = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyrightconfig.json", "setup.py", "requirements.txt", ".git" },
    capabilities = capabilities,
}

-- Lua Language Server
vim.lsp.config["lua_ls"] = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".git", "init.lua" },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = vim.split(package.path, ";"),
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
    capabilities = capabilities,
}

-- Assembly LSP
vim.lsp.config["asm_lsp"] = {
    cmd = { "asm-lsp" },
    filetypes = { "asm", "assembly" },
    capabilities = capabilities,
}

-- CMake
vim.lsp.config["cmake"] = {
    cmd = { "cmake-language-server" },
    filetypes = { "cmake" },
    init_options = {
        buildDirectory = "build",
    },
    root_markers = { "CMakeLists.txt" },
    capabilities = capabilities,
}

-- YAML
vim.lsp.config["yamlls"] = {
    capabilities = capabilities,
    settings = {
        yaml = {
            schemas = {
                kubernetes = "*.k8s.yaml",
                ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
                ["https://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
            },
            validate = true,
            format = { enable = true },
            completion = true,
        },
    },
}

-- Bash
vim.lsp.config["bashls"] = {
    capabilities = capabilities,
    filetypes = { "sh", "zsh", "bash" },
}

-- Rust Analyzer
vim.lsp.config["rust_analyzer"] = {
    cmd = { "rust-analyzer" },
    capabilities = capabilities,
    filetypes = { "rust" },
    settings = {
        ["rust-analyzer"] = {
            diagnostics = {
                enable = false,
            },
        },
    },
}

-- HTML
vim.lsp.config["html"] = {
    cmd = { "vscode-html-language-server", "--stdio" },
    capabilities = capabilities,
    filetypes = { "html", "templ" },
    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
            css = true,
            javascript = true,
        },
        provideFormatter = true,
    },
}

-- CSS
vim.lsp.config["cssls"] = {
    cmd = { "vscode-css-language-server", "--stdio" },
    root_markers = { "package.json", ".git" },
    capabilities = capabilities,
    filetypes = { "css", "scss", "less" },
    init_options = {
        provideFormatter = true,
    },
}

-- Zig
vim.lsp.config["zls"] = {
    cmd = { "zls" },
    filetypes = { "zig", "zir" },
    root_markers = { "zls.json", "build.zig", ".git" },
    capabilities = capabilities,
}
