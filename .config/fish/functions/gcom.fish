function gcom -d "Checkout to main branch"
    set -l default_branch (__git.default_branch)
    git checkout $default_branch
end
