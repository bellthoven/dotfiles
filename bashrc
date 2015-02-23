. /usr/local/git/contrib/completion/git-completion.bash

function format_ps1() {
  local white_bold="\033[01;37m" green="\033[00;32m" \
    blue="\033[00;34m" yellow="\033[00;33m" reset="\033[0m" \
    jobcount="\$(echo \$(jobs | wc -l))"
  echo -n "$white_bold[$reset\t "
  echo -n "$green\u$reset$blue@$reset$green\h$reset "
  echo -n "$blue\w$reset "
  echo -n "$yellow$jobcount jobs$reset"
  echo -n "$white_bold]$reset"
  echo -ne "\n\$ "
}

export PS1="$(format_ps1)"
unset -f format_ps1

export CDPATH=".:~:~/src/"
export EDITOR=vim
export NO_DEPRECATIONS=1

function redis.start() {
  echo daemonize yes | redis-server -
}

function desample () { cp "$1" "${1%%.sample}" ; }

function redis-server-at () {
  {
    echo "daemonize yes"
    echo "dbfilename `basename $1`"
    echo "dir `dirname $1`"
  } | redis-server -
}

alias grep="$(which grep) --exclude-dir=.git -r -n --color=always"
alias sgrep="$(which grep) --exclude-dir=.git -r -n --color=always -C3"
alias less="less -r"
alias bashrc="vim ~/.bashrc"
alias vimrc="vim ~/.vimrc"
alias tlog="tail -f log/development.log"

shopt -s autocd

source /opt/boxen/env.sh
unalias git

function s () {
  if [ $# -eq 0 ]; then
    tmux list-sessions
  else
    tmux attach-session -t "$@"
  fi
}

function t () {
  local file="$(echo $1 | cut -d: -f1)" line="$(echo $1 | cut -d: -f2)"

  local test_name="$(cat $file | sed -n "${line}p" | sed "s/^[[:space:]]*test \([\"']\)\(.*\)\1[[:space:]]*\(do\)*{*/test_\2/g" | sed 's/[[:space:]]/_/')"

  echo rake test "$file" "$test_name"
  rake test "$file" "$test_name"
}

gifify() {
  if [[ -n "$1" ]]; then
    if [[ $2 == '--good' ]]; then
      ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
      time convert -verbose +dither -layers Optimize -resize 600x600\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > $1.gif
      rm out-static*.png
    else
      ffmpeg -i $1 -s 600x400\> -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $1.gif
    fi
  else
    echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}
