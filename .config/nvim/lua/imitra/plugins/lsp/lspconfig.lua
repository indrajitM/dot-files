return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness

    -- Set up keymaps for LSP using LspAttach autocmd
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(args)
        local bufnr = args.buf
        local opts = { noremap = true, silent = true, buffer = bufnr }

        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", function()
          vim.lsp.stop_client(vim.lsp.get_clients({ bufnr = bufnr }))
          vim.cmd("edit")
        end, opts) -- mapping to restart lsp if necessary
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
    })

    -- configure html server
    -- lspconfig["html"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- })

    -- configure typescript server with plugin
    -- lspconfig["tsserver"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- })

    -- configure css server
    -- lspconfig["cssls"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- })

    -- configure tailwindcss server
    -- lspconfig["tailwindcss"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- })

    -- configure svelte server
    -- lspconfig["svelte"].setup({
    --   capabilities = capabilities,
    --   on_attach = function(client, bufnr)
    --     on_attach(client, bufnr)

    --     vim.api.nvim_create_autocmd("BufWritePost", {
    --       pattern = { "*.js", "*.ts" },
    --       callback = function(ctx)
    --         if client.name == "svelte" then
    --           client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
    --         end
    --       end,
    --     })
    --   end,
    -- })

    -- configure prisma orm server
    -- lspconfig["prismals"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- })

    -- configure graphql language server
    -- lspconfig["graphql"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    --   filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    -- })

    -- configure emmet language server
    -- lspconfig["emmet_ls"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    --   filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    -- })

    -- configure python server
    -- lspconfig["pyright"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- })

    -- configure clangd server
    vim.lsp.config.clangd = {
      cmd = { "clangd" },
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
      root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", "configure.ac", ".git" },
      capabilities = capabilities,
    }
    vim.lsp.enable("clangd")

    -- configure lua server (with special settings)
    vim.lsp.config.lua_ls = {
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
      root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
      capabilities = capabilities,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    }
    vim.lsp.enable("lua_ls")
  end,
}
