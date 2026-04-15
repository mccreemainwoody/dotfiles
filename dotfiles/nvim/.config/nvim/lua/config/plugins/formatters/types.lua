local formatters = {
    -- Custom formatter modules
    nix = { command = "nix", args = { "fmt" } },
}

return {
    get_formatters = function()
        return formatters
    end,
}
