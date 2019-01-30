function hello_world
  echo Hello World $argv
end

function peco_history --description 'search previously used command through peco'
  history --search --contains $argv[1] | peco
end

function peco_git_branch --description 'Check out a branch interactively'
  set dir (basename $PWD)
  git branch -a | peco --prompt="[$dir] Checkout branch:" --query="$argv" | tr -d ' ' > /tmp/branchname
  set selected_branch_name (cat /tmp/branchname)

  # Remove remote/ if its part of the branchname
  switch $selected_branch_name
  case '*-\>*'
      set selected_branch_name (echo $selected_branch_name | perl -ne 's/^.*->(.*?)\/(.*)$/\2/;print')
  case 'remotes*'
      set selected_branch_name (echo $selected_branch_name | perl -ne 's/^.*?remotes\/(.*?)\/(.*)$/\2/;print')
  end

  set selected_branch_name (echo $selected_branch_name | sed -e 's/\*//g')

  # Do the actual checkout
  echo "Checking out $selected_branch_name"
  git checkout $selected_branch_name
end

function process_port --description 'Show process to use port'
  lsof -n -P -i :$argv
end

function kill_port --description 'Kill proces to use port'
  kill -9 (lsof -n -P -i :$argv -t)
end

function mov_to_gif --description 'Movie file to gif for github'
  ffmpeg -i $argv[1] -vf scale=640:-1 -r 10 $argv[1].gif
end

function clean_local_branch --description 'clean local branchs merged master'
  git branch --merged master | grep -vE '^\*|master$|develop$' | xargs -I % git branch -d %
end

function clean_remote_branch --description 'clean remote branchs merged master'
  git branch -r --merged master | grep -v -e master -e develop | sed -e 's% *origin/%%' | xargs -I% git push --delete origin %
end

function update_macos --description 'Update mac OS by CLI'
  softwareupdate -i -a
end

function fish_prompt
  if [ $status -eq 0 ]
    set status_face (set_color white)"( ´ω` ) < "
  else
    set status_face (set_color white)"( `ω´ ) ? "
  end

  set -l git_dir (git rev-parse --git-dir 2> /dev/null)
  set propmt (set_color 0AD3FF)(pwd)

  if test -n "$git_dir"
    echo $propmt (parse_git_branch)
    echo $status_face
  else
    echo $propmt
    echo $status_face
  end
end

function parse_git_branch
  set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
  echo (set_color 78FFD6)'['$branch']'(set_color normal)
end

function fish_right_prompt
  set -l now (date +"%Y/%m/%d %H:%M:%S")
  echo (set_color E1FAF9)'['$now']'(set_color normal)
end

function fish_user_key_bindings
  bind \cx\ck peco_kill
  bind \cr peco_select_history
  # fzf
  bind \cx\cf '__fzf_find_file'
  bind \ctr '__fzf_reverse_isearch'
  bind \ex '__fzf_find_and_execute'
  bind \ed '__fzf_cd'
  bind \eD '__fzf_cd_with_hidden'
end

set -x PATH $HOME/.anyenv/bin $PATH
set PATH /Users/(whoami)/bin/ $PATH

# AWS-CLI
set PATH /Users/(whoami)/.Local/bin $PATH
set -x JAVA_HOME (/usr/libexec/java_home -v "1.8")

# alias
alias delete-merged-branch="git branch --merged|egrep -v '\\*|develop|master'|xargs git branch -d"
alias readlink="greadlink"

# anyenv
set -x PATH $HOME/.anyenv/bin $PATH

# rbenv
set -x RBENV_ROOT $HOME/.anyenv/envs/rbenv
set -x PATH $RBENV_ROOT/bin $PATH
set -x PATH $RBENV_ROOT/shims $PATH

# ndenv
set -x NDENV_ROOT $HOME/.anyenv/envs/ndenv
set -x PATH $NDENV_ROOT/bin $PATH
set -x PATH $NDENV_ROOT/shims $PATH

# pyenv
set -x PYENV_ROOT $HOME/.anyenv/envs/pyenv
set -x PATH $PYENV_ROOT/bin $PATH
set -x PATH $PYENV_ROOT/shims $PATH

# goenv
set -x GOENV_ROOT $HOME/.anyenv/envs/goenv
set -x PATH $GOENV_ROOT/bin $PATH
set -x PATH $GOENV_ROOT/shims $PATH

# show envs settings
anyenv versions

# oracle
set -x ORACLE_HOME $HOME/oracle
set -x PATH $ORACLE_HOME/client $PATH

# rust
set -U fish_user_paths $fish_user_paths $HOME/.cargo/bin

# for webpack build
set -x NODE_OPTIONS "--max-old-space-size=4096"
