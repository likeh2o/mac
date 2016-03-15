alias vi='vim';
alias rm='rm -i';
alias ll='ls -l';
alias tail='tail -f';

## Parses out the branch name from .git/HEAD:
find_git_branch () {
    local dir=. head
    until [ "$dir" -ef / ]; do
        if [ -f "$dir/.git/HEAD" ]; then
            head=$(< "$dir/.git/HEAD")
            if [[ $head = ref:\ refs/heads/* ]]; then
                git_branch=" → ${head#*/*/}"
            elif [[ $head != '' ]]; then
                git_branch=" → (detached)"
            else
                git_branch=" → (unknow)"
            fi
            return
        fi
        dir="../$dir"
    done
    git_branch=''
}
PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"
green=$'\e[1;32m'
magenta=$'\e[1;35m'
normal_colours=$'\e[m'

#PS1="\[$green\]\u@\h:\w\[$magenta\]\$git_branch\[$green\]\\$\[$normal_colours\] "
PS1="\[$normal_colours\][\u@\h:\[$green\]\w\[$magenta\]\$git_branch\[$normal_colours\]]\\$\[$normal_colours\] "
