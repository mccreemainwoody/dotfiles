#!/usr/bin/nu

source ~/.config/nushell/prompt/colors.nu

######################################################

# Abbreviate home path for the prompt
def home_abbrev [os_name] {
    let is_home_in_path = ($env.PWD | str starts-with $nu.home-path)
    if $is_home_in_path {
        if ($os_name == "windows") {
            let home = ($nu.home-path | str replace -ar '\\' '/')
            let pwd = ($env.PWD | str replace -ar '\\' '/')
            $pwd | str replace $home '~'
        } else {
            $env.PWD | str replace $nu.home-path '~'
        }
    } else {
        $env.PWD | str replace -ar '\\' '/'
    }
}

# get the operating system icon for the prompt
def get_os_icon [os] {
    # f17c = tux, f179 = apple, f17a = windows
    if ($os.name =~ macos) {
        (char -u f179)
    } else if ($os.name =~ windows) {
        (char -u f17a)
    } else if ($os.kernel_version =~ WSL) {
        $'(char -u f17a)(char -u f17c)'
    } else if ($os.family =~ unix) {
        (char -u f17c)
    } else {
        ''
    }
}

# get the os segment for the prompt
def get_os_segment [os color_mode] {
    let os_bg_color = (get_color os_bg_color $color_mode)
    let os_color = (get_color os_color $color_mode)
    let os_icon = (get_os_icon $os)

    let user = $env.USER
    let hostname = (sys host).hostname
    let user_information_display = ($user) + "@" + ($hostname)

    let transition_icon = $left_prompt_separator_diff_color
    let transition_bg_color = (get_color pwd_bg_color $color_mode)
    let transition_color = (get_color pwd_color_anchors $color_mode)

    let os_segment = (
    [
        ($os_color)
        ($os_bg_color)
        (char space)
        ($os_icon)
        (char space)
        ($user_information_display)
        (char space)
        ($transition_color)
        ($transition_bg_color)
        ($transition_icon)
        (char space)
    ] | str join
    )

    $os_segment
}

# get the path segment for the prompt
def get_path_segment [os color_mode] {
    let display_path = (home_abbrev $os.name)
    let is_home_in_path = ($env.PWD | str starts-with $nu.home-path)
    let pwd_bg_color = (get_color pwd_bg_color $color_mode)
    let pwd_color = (get_color pwd_color_dirs $color_mode)
    let home_or_folder = (if $is_home_in_path { (char nf_house1) } else { (char nf_folder1) })

    let transition_icon = $left_prompt_separator_diff_color
    let transition_bg_color = (get_color git_bg_color $color_mode)
    let transition_color = (get_color pwd_bg_color $color_mode)

    let path_segment = (
        [
            $home_or_folder
            (char space)                           # space
            $display_path                          # ~/src/forks/nushell
            ($pwd_color)
            ($pwd_bg_color)
            (char space)                           # space
            ($transition_color)
            ($transition_bg_color)
            ($transition_icon)
            (char space)
        ] | str join
    )

    $path_segment
}

# get Git branch
def get_git_branch_segment [color_mode] {
    let git_branch_fg = (get_color git_color_branch $color_mode)
    let git_branch_bg = (get_color git_bg_color $color_mode)
    let git_icon = (char -u efa0)

    let in_git_repo = (ls -a | where type == dir and name == .git | length) > 0
    let git_branch = (git branch --show-current | complete | get stdout | head)

    let git_branch_segment = (
        [
            ($git_branch_fg)
            ($git_branch_bg)
            $git_icon
            (char space)
            (if $in_git_repo { $git_branch} else "")
            (char space)
        ] | str join
    )

    $git_branch_segment
}

# get the indicator segment for the prompt
def get_indicator_segment [os color_mode] {
    let R = (ansi reset)
    let indicator_color = (get_color indicator_color $color_mode)
    let indicator_bg_color = (get_color indicator_bg_color $color_mode)
    let indicator_segment = (
        [
        ($indicator_color)
        ($indicator_bg_color)
        (char nf_segment)                         # 
        ($R)                                   # reset color
        ] | str join
    )

    $indicator_segment
}

# get the time segment for the prompt
def get_time_segment [os color_mode] {
    let R = (ansi reset)
    let time_bg_color = (get_color time_bg_color $color_mode)
    let time_color = (get_color time_color $color_mode)

    let time_segment = ([
        (ansi { fg: $time_bg_color bg: $time_color})
        (char nf_right_segment) #(char -u e0b2)     # 
        ($time_color)
        ($time_bg_color)
        (char space)
        (date now | format date '%I:%M:%S %p')
        (char space)
        ($R)
    ] | str join)

    $time_segment
}

# get the status segment for the prompt
def get_status_segment [os color_mode] {
    let R = (ansi reset)

    # set status bg color to foreground since bg is dark
    let fg_failure = (get_color status_bg_color_failure $color_mode)
    let term_bg_color = (get_color terminal_bg_color $color_mode)
    let cmd_dur_fg = (get_color cmd_duration_ms_color $color_mode)
    let cmd_dur_bg = (get_color cmd_duration_ms_bg_color $color_mode)

    let status_segment = (
        [
            (if $env.LAST_EXIT_CODE != 0 {
                (ansi { fg: $fg_failure bg: $term_bg_color })
            } else {
                (ansi { fg: $cmd_dur_fg bg: $cmd_dur_bg })
            })
            (char nf_right_segment_thin)
            (char space)
            $env.LAST_EXIT_CODE
            (char space)
            ($R)
        ] | str join
    )

    $status_segment
}

# get the execution segment for the prompt
def get_execution_time_segment [os color_mode] {
    let R = (ansi reset)
    let cmd_dur_fg = (get_color cmd_duration_ms_color $color_mode)
    let cmd_dur_bg = (get_color cmd_duration_ms_bg_color $color_mode)

    let cmd_duration_in_seconds = ($env.CMD_DURATION_MS | into int) / 1000

    let execution_time_segment = (
        [
            ($cmd_dur_fg)
            ($cmd_dur_bg)
            # (ansi { fg: $cmd_dur_fg bg: $cmd_dur_bg })
            (char nf_right_segment_thin)
            (char space)
            ($cmd_duration_in_seconds)
            "s"
            (char space)
            ($R)
        ] | str join
    )

    $execution_time_segment
}
