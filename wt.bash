# Shell function for wt command (bash)
# Add to ~/.bashrc:
#   source ~/code/oss/worktree/wt.bash

wt() {
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local script_path="$script_dir/wt"

    "$script_path" "$@"
    local exit_code=$?

    # If creation was successful and path was saved, cd into it
    if [ $exit_code -eq 0 ] && [ -f /tmp/wt-last-path ] && [[ "$1" == "-c" || "$1" == "--create" ]]; then
        local new_path=$(cat /tmp/wt-last-path)
        rm -f /tmp/wt-last-path
        if [ -d "$new_path" ]; then
            cd "$new_path" || return 1
            echo
            echo "Now in: $new_path"
        fi
    fi

    # If nuke was successful and path was saved, cd to main repo
    if [ $exit_code -eq 0 ] && [ -f /tmp/wt-nuke-path ] && [[ "$1" == "--nuke" ]]; then
        local main_path=$(cat /tmp/wt-nuke-path)
        rm -f /tmp/wt-nuke-path
        if [ -d "$main_path" ]; then
            cd "$main_path" || return 1
            echo
            echo "Now in: $main_path"
        fi
    fi

    return $exit_code
}
