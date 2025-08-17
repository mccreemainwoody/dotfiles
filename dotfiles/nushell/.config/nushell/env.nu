#!/usr/bin/nu

# Editor
$env.config.buffer_editor = "nvim"

# Kitty integration
$env.config.use_kitty_protocol = true

# Disable startup banner
$env.config.show_banner = false

# Carapace-based command completions
if ((which carapace | length) > 0) {
    $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
    mkdir ~/.cache/carapace
    carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
}
