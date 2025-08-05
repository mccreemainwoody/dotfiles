plugin_manager_config = require("plugin_manager.config")

init_plugin_manager = function()
	-- [[ Configure and install plugins ]]
	--
	--  To check the current status of your plugins, run
	--    :Lazy
	--
	--  You can press `?` in this menu for help. Use `:q` to close the window
	--
	--  To update plugins you can run
	--    :Lazy update
	--
	-- NOTE: Here is where you install your plugins.
	require("lazy").setup("plugins", plugin_manager_config)
end

return {
	init = init_plugin_manager,
}
