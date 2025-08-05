return {
    setup = function()
        require("plugin_manager.install").install()
        require("plugin_manager.setup").init()
    end,
}
