function gpx
    # Check if we're in a git repository
    if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
        echo "Error: not a git repository"
        return 1
    end

    # Get current branch name
    set current_branch (git rev-parse --abbrev-ref HEAD)

    # Show status
    echo "Current branch: $current_branch"
    git status

    # Prompt for confirmation
    read -l -P "Continue with push? [y/N] " confirm
    if test "$confirm" != "y"
        echo "Push cancelled"
        return
    end

    # Pull latest changes first
    echo "Pulling latest changes..."
    if not git pull origin $current_branch
        echo "Pull failed. Please resolve conflicts first"
        return 1
    end

    # Add all changes
    git add .

    # Handle commit message
    if test (count $argv) -gt 0
        git commit -m "$argv"
    else
        read -l -P "Enter commit message [default: updated]: " message
        if test -z "$message"
            git commit -m "updated"
        else
            git commit -m "$message"
        end
    end

    # Push to remote
    if git push origin $current_branch
        echo "Successfully pushed to $current_branch"
    else
        echo "Push failed"
        return 1
    end
end
