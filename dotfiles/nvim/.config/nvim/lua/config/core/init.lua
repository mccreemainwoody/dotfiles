local vim_options = require("config.core.vim_options")
local keymap = require("config.core.keymap")
local autocommands = require("config.core.autocommands")

return {
	setup_all = function()
		vim_options.setup_vim_options()
		keymap.setup_keymap()
		autocommands.setup_autocommands()
	end,
	setup_vim_options = vim_options.setup_vim_options,
	setup_keymap = keymap.setup_keymap,
	setup_autocommands = autocommands.setup_autocommands,
}
