vim_options = require("config/vim_options")
keymap = require("config/keymap")
autocommands = require("config/autocommands")

return {
	setup_all = function()
		vim_options.setup_vim_options()
		keymap.setup_keymap()
		autocommands.setup_autocommands()
	end,
	setup_vim_options = vim_options.setup_vim_options,
	setup_keymap = keymap.setup_vim_options,
	setup_autocommands = autocommands.setup_autocommands,
}
