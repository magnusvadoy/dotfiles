function git-update-all -d "Pull all immediate child Git repos"
    for dir in */
        test -e "$dir/.git"; or continue
        printf '\nUpdating %s\n' "$dir"
        git -C "$dir" pull --ff-only
    end
end
