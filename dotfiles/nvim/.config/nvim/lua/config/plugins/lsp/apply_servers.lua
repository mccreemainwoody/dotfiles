return {
    apply_servers = function(servers)
        -- Ensure the servers and tools above are installed
        --
        -- To check the current status of installed tools and/or manually install
        -- other tools, you can run
        --    :Mason
        --
        -- You can press `g?` for help in this menu.
        --
        -- `mason` had to be setup earlier: to configure its options see the
        -- `dependencies` table for `nvim-lspconfig` above.
        --
        -- You can add other tools here that you want Mason to install
        -- for you, so that they are available from within Neovim.
        local ensure_installed = vim.tbl_keys(servers or {})

        vim.list_extend(ensure_installed, {
            "stylua", -- Used to format Lua code
        })

        require("mason-tool-installer").setup({
            ensure_installed = ensure_installed,
        })

        -- LSP servers and clients are able to communicate to each other what features they support.
        --  By default, Neovim doesn't support everything that is in the LSP specification.
        --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
        --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        require("mason-lspconfig").setup({
            ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
            automatic_installation = false,
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    -- This handles overriding only values explicitly passed
                    -- by the server configuration above. Useful when disabling
                    -- certain features of an LSP (for example, turning off formatting for ts_ls)
                    server.capabilities = vim.tbl_deep_extend(
                        "force",
                        {},
                        capabilities,
                        server.capabilities or {}
                    )
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })
    end,
}
