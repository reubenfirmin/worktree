# Fish function for wt command
# Add to ~/.config/fish/config.fish:
#   source ~/code/oss/worktree/wt.fish

function wt
    set script_dir (dirname (status -f))
    set script_path "$script_dir/wt"

    # For nuke, pre-read the target path before running (cwd will be deleted)
    set -l nuke_target ""
    if test "$argv[1]" = "--nuke"
        $script_path $argv
        set exit_code $status
        if test $exit_code -eq 0; and test -f /tmp/wt-nuke-path
            set nuke_target (cat /tmp/wt-nuke-path)
            rm -f /tmp/wt-nuke-path
            if test -d "$nuke_target"
                cd "$nuke_target"
                echo
                echo "Now in: $nuke_target"
            end
        end
        return $exit_code
    end

    # Run the script
    $script_path $argv
    set exit_code $status

    # If creation was successful and path was saved, cd into it
    if test $exit_code -eq 0; and test -f /tmp/wt-last-path
        if test "$argv[1]" = "-c"; or test "$argv[1]" = "--create"
            set new_path (cat /tmp/wt-last-path)
            rm -f /tmp/wt-last-path
            if test -d "$new_path"
                cd "$new_path"
                echo
                echo "Now in: $new_path"
            end
        end
    end

    return $exit_code
end
