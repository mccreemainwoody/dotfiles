return {
    get_configuration = function()
        return {
            notify_on_error = true,
            format_on_save = function(bufnr)
                -- Disable "format_on_save lsp_fallback" for languages that don't
                -- have a well standardized coding style. You can add additional
                -- languages here or re-enable it for the disabled ones.
                local disable_filetypes = { txt = true }
                return disable_filetypes[vim.bo[bufnr].filetype] and nil
                    or {
                        timeout_ms = 500,
                        lsp_format = "fallback",
                    }
            end,
            formatters_by_ft = require("config.plugins.formatters.formatters").get_formatters(),
        }
    end,
}
