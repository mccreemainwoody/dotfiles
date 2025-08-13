#!/usr/bin/nu

source ~/.config/nushell/prompt/parameters.nu

const runtime_colors = [
    { name: prompt_color_frame_and_connection, '8bit': $prompt_color_frame_and_connection_8, '24bit': $prompt_color_frame_and_connection_24 },
    { name: prompt_color_separator_same_color, '8bit': $prompt_color_separator_same_color_8, '24bit': $prompt_color_separator_same_color_24 },
    { name: left_separator_diff_color, '8bit': $left_prompt_separator_diff_color, '24bit': $left_prompt_separator_diff_color },
    { name: left_separator_same_color, '8bit': $left_prompt_separator_same_color, '24bit': $left_prompt_separator_same_color },
    { name: left_prefix, value: null },
    { name: left_suffix, value: null },
    { name: right_separator_diff_color, '8bit': $right_prompt_separator_diff_color, '24bit': $right_prompt_separator_diff_color },
    { name: right_separator_same_color, '8bit': $right_prompt_separator_same_color, '24bit': $right_prompt_separator_same_color },
    { name: right_prefix, value: null },
    { name: right_suffix, value: null },

    { name: cmd_bg_color, '8bit': $cmd_duration_bg_color_8, '24bit': $cmd_duration_bg_color_24 },
    { name: cmd_color, '8bit': $cmd_duration_color_8, '24bit': $cmd_duration_color_24 },
    { name: cmd_decimals, value: 2 },
    { name: cmd_icon, value:  },

    { name: git_bg_color, '8bit': $git_bg_color_8, '24bit': $git_bg_color_24 },
    { name: git_bg_color_unstable, '8bit': $git_bg_color_unstable_8, '24bit': $git_bg_color_unstable_24 },
    { name: git_bg_color_urgent, '8bit': $git_bg_color_urgent_8 , '24bit': $git_bg_color_urgent_24 },
    { name: git_color_branch, '8bit': $git_color_branch_8, '24bit': $git_color_branch_24 },
    { name: git_color_conflicted, '8bit': $git_color_conflicted_8, '24bit': $git_color_conflicted_24 },
    { name: git_color_dirty, '8bit': $git_color_dirty_8, '24bit': $git_color_dirty_24 },
    { name: git_color_operation, '8bit': $git_color_operation_8, '24bit': $git_color_operation_24 },
    { name: git_color_staged, '8bit': $git_color_staged_8, '24bit': $git_color_staged_24 },
    { name: git_color_stash, '8bit': $git_color_stash_8, '24bit': $git_color_stash_24 },
    { name: git_color_untracked, '8bit': $git_color_untracked_8, '24bit': $git_color_untracked_24 },
    { name: git_color_upstream, '8bit': $git_color_upstream_8, '24bit': $git_color_upstream_24 },

    { name: os_bg_color, '8bit': $os_bg_color_8, '24bit': $os_bg_color_24 },
    { name: os_color, '8bit': $os_color_8, '24bit': $os_color_24 },

    { name: pwd_bg_color, '8bit': $pwd_bg_color_8, '24bit': $pwd_bg_color_24 },
    { name: pwd_color_anchors, '8bit': $pwd_color_anchors_8, '24bit': $pwd_color_anchors_24 },
    { name: pwd_color_dirs, '8bit': $pwd_color_dirs_8, '24bit': $pwd_color_dirs_24 },
    { name: pwd_color_truncated_dirs, '8bit': $pwd_color_truncated_dirs_8, '24bit': $pwd_color_truncated_dirs_24 },
    { name: pwd_icon, value: null },
    { name: pwd_icon_home, value: null },
    { name: pwd_icon_unwritable, value: null },

    { name: rustc_bg_color, '8bit': $rustc_bg_color_8, '24bit': $rustc_bg_color_24 },
    { name: rustc_color, '8bit': $rustc_color_8, '24bit': $rustc_color_24 },
    { name: rustc_icon, value:  },

    { name: status_bg_color, '8bit': $status_bg_color_8, '24bit': $status_bg_color_24 },
    { name: status_bg_color_failure, '8bit': $status_bg_color_failure_8, '24bit': $status_bg_color_failure_24 },
    { name: status_color, '8bit': $status_color_8, '24bit': $status_color_24 },
    { name: status_color_failure, '8bit': $status_color_failure_8 , '24bit': $status_color_failure_24 },
    { name: status_icon, value: null },
    { name: status_icon_failure, value: null },

    { name: time_bg_color, '8bit': $time_bg_color_8, '24bit': $time_bg_color_24 },
    { name: time_color, '8bit': $time_color_8, '24bit': $time_color_24 },
    { name: time_format, value: null },

    { name: indicator_bg_color, '8bit': $indicator_bg_color_8, '24bit': $indicator_bg_color_24 },
    { name: indicator_color, '8bit': $indicator_color_8, '24bit': $indicator_color_24 },

    { name: terminal_color, '8bit': $terminal_color_8, '24bit': $terminal_color_24 },
    { name: terminal_bg_color, '8bit': $terminal_bg_color_8, '24bit': $terminal_bg_color_24 },

    {name: cmd_duration_ms_color, '8bit': $cmd_duration_ms_color_8, '24bit': $cmd_duration_ms_color_24 },
    {name: cmd_duration_ms_bg_color, '8bit': $cmd_duration_ms_bg_color_8, '24bit': $cmd_duration_ms_bg_color_24 },
]

# get the color from the $runtime_colors array
def get_color [name, mode] {
    $runtime_colors | where name == $name | get $mode | get 0
}
