# See the readme for how to use this script
# modes
# * 8bit
# * 24bit
const color_mode = "24bit"

# setup separate characters
const left_prompt_separator_diff_color = (char -u 'e0b0')
const left_prompt_separator_same_color = (char -u 'e0b1')
const right_prompt_separator_diff_color = (char -u 'e0b2')
const right_prompt_separator_same_color = (char -u 'e0b3')

# setup color variables for 24bit and 8bit
# prompt
const prompt_color_frame_and_connection_24 = (ansi -e { fg: "#6C6C6C" })
const prompt_color_separator_same_color_24 = (ansi -e { fg: "#949494" })
const prompt_color_frame_and_connection_8 = $"(ansi idx_fg)242m"
const prompt_color_separator_same_color_8 = $"(ansi idx_fg)246m"
const prompt_add_new_line_before = false
const prompt_color_frame_and_connection = ""
const prompt_color_separator_same_color = ""

const left_separator_diff_color = ""
const left_separator_same_color = ""
const left_items = []
const left_prefix = ""
const left_suffix = ""

const right_separator_diff_color = ""
const right_separator_same_color = ""
const right_items = []
const right_prefix = ""
const right_suffix = ""

# cmd
const cmd_duration_bg_color_24 = (ansi -e { bg: "#C4A000" })
const cmd_duration_color_24 = (ansi -e { fg: "#000000" })
const cmd_duration_bg_color_8 = $"(ansi idx_bg)178m"
const cmd_duration_color_8 = $"(ansi idx_fg)16m"
const cmd_bg_color = ""
const cmd_color = ""
const cmd_decimals = 2
const cmd_icon = ""

# git
const git_bg_color_24 = (ansi -e { bg: "#4E9A06" })
const git_bg_color_unstable_24 = (ansi -e { bg: "#C4A000" })
const git_bg_color_urgent_24 = (ansi -e { bg: "#CC0000" })
const git_color_branch_24 = (ansi -e { fg: "#000000" })
const git_color_conflicted_24 = (ansi -e { fg: "#000000" })
const git_color_dirty_24 = (ansi -e { fg: "#000000" })
const git_color_operation_24 = (ansi -e { fg: "#000000" })
const git_color_staged_24 = (ansi -e { fg: "#000000" })
const git_color_stash_24 = (ansi -e { fg: "#000000" })
const git_color_untracked_24 = (ansi -e { fg: "#000000" })
const git_color_upstream_24 = (ansi -e { fg: "#000000" })

const git_bg_color_8 = $"(ansi idx_bg)70m"
const git_bg_color_unstable_8 = $"(ansi idx_bg)178m"
const git_bg_color_urgent_8 = $"(ansi idx_bg)160m"
const git_color_branch_8 = $"(ansi idx_fg)16m"
const git_color_conflicted_8 = $"(ansi idx_fg)16m"
const git_color_dirty_8 = $"(ansi idx_fg)16m"
const git_color_operation_8 = $"(ansi idx_fg)16m"
const git_color_staged_8 = $"(ansi idx_fg)16m"
const git_color_stash_8 = $"(ansi idx_fg)16m"
const git_color_untracked_8 = $"(ansi idx_fg)16m"
const git_color_upstream_8 = $"(ansi idx_fg)16m"

const git_bg_color = ""
const git_bg_color_unstable = ""
const git_bg_color_urgent = ""
const git_color_branch = ""
const git_color_conflicted = ""
const git_color_dirty = ""
const git_color_operation = ""
const git_color_staged = ""
const git_color_stash = ""
const git_color_untracked = ""
const git_color_upstream = ""

# os
const os_bg_color_24 = (ansi -e { bg: "#CED7CF" })
const os_color_24 = (ansi -e { fg: "#080808" })
const os_bg_color_8 = $"(ansi idx_bg)188m"
const os_color_8 = $"(ansi idx_fg)232m"
const os_bg_color = ""
const os_color = ""

# pwd
const pwd_bg_color_24 = (ansi -e { bg: "#3465A4" })
const pwd_color_anchors_24 = (ansi -e { fg: "#E4E4E4" })
const pwd_color_dirs_24 = (ansi -e { fg: "#E4E4E4" })
const pwd_color_truncated_dirs_24 = (ansi -e { fg: "#BCBCBC" })

const pwd_bg_color_8 = $"(ansi idx_bg)61m"
const pwd_color_anchors_8 = $"(ansi idx_fg)254m"
const pwd_color_dirs_8 = $"(ansi idx_fg)254m"
const pwd_color_truncated_dirs_8 = $"(ansi idx_fg)250m"

const pwd_bg_color = ""
const pwd_color_anchors = ""
const pwd_color_dirs = ""
const pwd_color_truncated_dirs = ""
const pwd_icon = ""
const pwd_icon_home = ""
const pwd_icon_unwritable = ""
const pwd_markers = []

# rustc
const rustc_bg_color_24 = (ansi -e { bg: "#F74C00" })
const rustc_color_24 = (ansi -e { fg: "#000000" })
const rustc_bg_color_8 = $"(ansi idx_bg)202m"
const rustc_color_8 = $"(ansi idx_fg)16m"

const rustc_bg_color = ""
const rustc_color = ""
const rustc_icon = ""

# status
const status_bg_color_24 = (ansi -e { bg: "#2E3436" })
const status_bg_color_failure_24 = (ansi -e { bg: "#CC0000" })
const status_color_24 = (ansi -e { fg: "#4E9A06" })
const status_color_failure_24 = (ansi -e { fg: "#FFFF00" })

const status_bg_color_8 = $"(ansi idx_bg)236m"
const status_bg_color_failure_8 = $"(ansi idx_bg)160m"
const status_color_8 = $"(ansi idx_fg)70m"
const status_color_failure_8 = $"(ansi idx_fg)226m"

const status_bg_color = ""
const status_bg_color_failure = ""
const status_color = ""
const status_color_failure = ""
const status_icon = ""
const status_icon_failure = ""

# time
const time_bg_color_24 = (ansi -e { bg: "#D3D7CF" })
const time_color_24 = (ansi -e { fg: "#000000" })
const time_bg_color_8 = $"(ansi idx_bg)188m"
const time_color_8 = $"(ansi idx_fg)16m"

const time_bg_color = ""
const time_color = ""
const time_format = ""

# indicator
const indicator_color_24 = (ansi -e { fg: "#4E9A06" })
const indicator_bg_color_24 = (ansi -e { bg: "#000000" })
const indicator_color_8 = $"(ansi idx_fg)16m"
const indicator_bg_color_8 = $"(ansi idx_bg)16m"

# terminal background color
const terminal_color_24 = (ansi -e { fg: "#c7c7c7" })
const terminal_color_8 = (ansi white)
const terminal_bg_color_24 = (ansi -e { bg: "#000000" })
const terminal_bg_color_8 = (ansi black)

# cmd_duration_ms
const cmd_duration_ms_color_24 = (ansi -e { fg: "#606060" })
const cmd_duration_ms_color_8 = $"(ansi idx_fg)244m"
const cmd_duration_ms_bg_color_24 = (ansi -e { fg: "#000000" })
const cmd_duration_ms_bg_color_8 = (ansi black)

