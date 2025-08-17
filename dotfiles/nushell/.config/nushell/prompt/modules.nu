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
    if ($os.name =~ macos) {
        return $icons_os_macos
    } else if ($os.name =~ windows) {
        return $icons_os_windows
    } else if ($os.kernel_version =~ WSL) {
        return $icons_os_wsl
    } else if ($os.family =~ unix) {
        return $icons_os_unix
    }

    $icons_os_default
}

# get the main remote of the current Git repo (assuming the repo exists)
def get_git_main_remote [] {
    let remote_sources = (git remote | parse "{id}")

    if (($remote_sources | where id == "origin" | length) < 1) {
        "origin"
    } else {
        ($remote_sources | get 0 | get id)
    }
}

# get the Git icon to display depending of the repo type
def get_git_icon [in_git_repo] {
    if (not $in_git_repo) {
        return $icons_git_branch_none
    }

    let main_remote = (get_git_main_remote)

    let remote_url = (git remote get-url $main_remote | complete | get stdout)

    if ($remote_url | str contains "github.com") {
        return $icons_git_branch_github
    } else if ($remote_url | str contains "gitlab") {
        return $icons_git_branch_gitlab
    } else if ($remote_url | str contains "bitbucket") {
        return $icons_git_branch_bitbucket
    } else if ($remote_url | str contains "codecommit") {
        return $icons_git_branch_codecommit
    } else if ($remote_url | str contains "git.forge.epita.fr") {
        return $icons_git_branch_epita
    }

    $icons_git_branch_default
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
    mut git_information_content = []

    if ((which git | length) == 1) {
        let git_branch_fg = (get_color git_color_branch $color_mode)
        let git_branch_bg = (get_color git_bg_color $color_mode)

        let git_status = (git branch --show-current | complete)
        let in_git_repo = ($git_status | get exit_code) == 0
        let git_branch = ($git_status | get stdout | head)

        let git_icon = (get_git_icon $in_git_repo)

        if ($in_git_repo and ($git_icon != "")) {
            $git_information_content = [
                ($git_branch_fg)
                ($git_branch_bg)
                $git_icon
                (char space)
                $git_branch
                (char space)
            ]
        }
    }

    let git_branch_segment = (
        [
            ...$git_information_content
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
        (date now | format date '%H:%M:%S %p')
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
