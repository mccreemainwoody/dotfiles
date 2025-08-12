# Original source: https://github.com/nushell/nu_scripts/blob/main/modules/prompt/oh-my-v2.nu

source ~/.config/nushell/prompt/modules.nu

# construct the left prompt
def get_left_prompt [os color_mode] {
    let os_segment = (get_os_segment $os $color_mode)
    let path_segment = (get_path_segment $os $color_mode)
    let indicator_segment = (get_indicator_segment $os $color_mode)
    $os_segment + $path_segment + $indicator_segment
}

# construct the right prompt
def get_right_prompt [os color_mode] {
    let status_segment = (get_status_segment $os $color_mode)
    let execution_time_segment = (get_execution_time_segment $os $color_mode)
    let time_segment = (get_time_segment $os $color_mode)
    let exit_if = (if $env.LAST_EXIT_CODE != 0 { $status_segment })
    [$exit_if $execution_time_segment $time_segment] | str join
}

# constructe the left and right prompt by color_mode (8bit or 24bit)
def get_prompt [color_mode] {
    # modes = 8bit or 24bit
    # let os = ((sys).host)
    let os = $nu.os-info
    let left_prompt = (get_left_prompt $os $color_mode)
    let right_prompt = (get_right_prompt $os $color_mode)

    # return in record literal syntax to be used kind of like a tuple
    # so we don't have to run this script more than once per prompt
    {
        left_prompt: $left_prompt
        right_prompt: $right_prompt
    }
}

$env.PROMPT_COMMAND = { (get_prompt 8bit).left_prompt }
$env.PROMPT_COMMAND_RIGHT = { (get_prompt 8bit).right_prompt }
$env.PROMPT_INDICATOR = { "" }
