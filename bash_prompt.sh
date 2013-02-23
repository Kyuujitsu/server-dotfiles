txtund=$(tput sgr 0 1)
txtbld=$(tput bold)

reset='\[\e[00m\]'
bold='\[\e[01m\]'
red='\[\e[31m\]'
green='\[\e[32m\]'
orange='\[\e[33m\]'
blue='\[\e[34m\]'
purple='\[\e[35m\]'
cyan='\[\e[36m\]'
gray='\[\e[37m\]'
bright='\[\e[39m\]'

function _get_prompt() {
  local git_status="`git status -unormal 2>&1`"
  if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
    if [[ "$git_status" =~ nothing\ to\ commit ]]; then
      local ansi=42
    elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
      local ansi=43
    else
      local ansi=45
    fi
    if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
      branch=${BASH_REMATCH[1]}
      test "$branch" != master || branch=' '
    else
      # Detached HEAD.  (branch=HEAD is a faster alternative.)
      branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null || echo HEAD`)"
    fi
    echo -n '\[\e[0;37;'"$ansi"';1m\]'"$branch"'\[\e[0m\] '
  fi
}

function _prompt_command() {
  PS1="`_git_prompt`"'$green\u@$blue\h$\$reset '
}

function short_pwd {
  pwd=$(pwd)
  first=$(basename $pwd)
  rest=$(dirname $pwd)
  second=$(basename $rest)
  rest=$(dirname $rest)
  third=$(basename $rest)
  if [ $second = "/" ]; then
    echo -n "/$first"
  elif [ $third = "/" ]; then
    echo -n "/$second/$first"
  else
    echo -n "$third/$second/$first"
  fi
}

function myprompt {
  git_top=$(git rev-parse --show-toplevel 2>/dev/null)

  if [ $? -ne 0 ]; then
    git_top=""
    GIT=0
  else
    git_top=$(basename $git_top)
    GIT=1
  fi

  if [ $GIT -ne 0 ]; then
    git_branch=$(git branch | grep "*" | awk '{print $2}')
    if [ $? -ne 0 ]; then
      git_branch=""
    fi

    if [ $git_branch = "master" ]; then
      branch="master"
    else
      branch=" $bold$red($git_branch)$reset"
    fi
  fi

  colordir="${bold}${blue}$(short_pwd)"
  if [ $GIT -ne 0 ]; then
    # We're in a git repo
    EDITS=$(git status -e | wc -l)
    if [ $EDITS -ne 0 ]; then
      edits=" $bold$orange($EDITS)$reset"
    else
      edits=""
    fi
    AHEAD=$(git rev-list @{u}..HEAD 2>/dev/null | wc -l)
    BEHIND=$(git rev-list HEAD..@{u} 2>/dev/null | wc -l)
    if [ $AHEAD -ne 0 -a $BEHIND -eq 0 ]; then
      ahead_behind="$bold$red +$AHEAD"
    elif [ $BEHIND -ne 0 -a $AHEAD -eq 0 ]; then
      ahead_behind="$bold$red -$BEHIND"
    elif [ $AHEAD -eq 0 -a $BEHIND -eq 0 ]; then
      ahead_behind=""
    else
      ahead_behind="$bold$red +$AHEAD -$BEHIND"
    fi
    git="${bold}${green}$git_top$edits$ahead_behind"
    PS1="$git$branch $colordir$reset\$ "
  else
    PS1="$colordir$reset\$ "
  fi
  if [ $VIRTUAL_ENV ]; then
    PS1="$bold$cyan$(basename $VIRTUAL_ENV)$reset $PS1"
  fi
}

unset PS1
if [ $user = 'tumodsru' ]; then
  PROMPT_COMMAND=mypromp
else
  PS1='\u@\h$ '
fi