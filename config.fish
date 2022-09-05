set d (date +%a' '%d/%m)
set t (date +%R)
set n (port installed | wc -l)
set k (uname -r | awk -F'-' '{print $1}')
set m (df -h / | awk -F' ' '{print $3 "/" $2}' | grep Gi)
set hide "--icon never -I Applications -I Movies -I Library -I Desktop -I Documents -I Downloads -I Music -I Pictures -I Public -I Templates -I Videos -I tags -I R -I conf.\*"
set hidez "-I .z\* -I .c\* -I .t\* -I .i\* -I .g\* -I .v\*"
set hidedot "-I .CFUserTextEncoding -I .DS_Store -I .Trash -I .anydesk -I .git -I .gitconfig -I .bashrc -I .python_history -I .pythonhist -I .lesshst -I .viminfo -I .cache -I .fonts -I .ipython -I R -I .r -I .pki -I .npm -I .lemminx -I .sonarlint -I .streamlit -I .vscode -I .java -I .local -I .moc -I .config -I .alacritty.yml -I .gnupg -I .wine"

alias l="lsd -l $hide"
alias ll="lsd -lA $hide $hidez $hidedot"
alias ok="cd && clear && fish_greeting"
alias fishcf="vim ~/my-mac/config.fish"

alias clpo="sudo port_cutleaves"
alias inpo="sudo port install"
alias rmpo="sudo port uninstall"
alias upo="sudo port selfupdate && sudo port upgrade outdated"

alias today="set_color red; print_center 99 Today is $d"
alias intro="print_center 98 Hello, I\'m Huy"
alias greeting="print_center 98 Have a nice day!"

function listenyt -a url
    youtube-dl -f bestaudio $url -o - 2>/dev/null | ffplay -nodisp -autoexit -i - &>/dev/null 
end

function print_center -a width
    set -e argv[1]
    set -l len (string length -- "$argv")
    if test $len -lt $width
        set -l half (math -s 0 "($width / 2)" + "($len / 2)")
        set -l rem (math -s 0 $width - $half)
        printf "%*.*s%*s\n" $half $len "$argv" $rem ' '
    else
        printf "%*.*s\n" $width $width "$argv"
    end
end

function fish_greeting
  clear
  today
  set_color magenta
  echo \n\t\t\t' '$t' '\t' '$n' '\t' '$m' '\t' '$k' '\n
  set_color yellow
  intro
  greeting
end

function cdls --on-variable PWD
  l
end

function cl
  sudo rm -rf /var/cache/
  rm ~/.bash_history
  rm ~/.zsh_history
  rm ~/.lesshst
  rm ~/.python_history
  rm ~/.pythonhist
  rm ~/.sqlite_history
  rm ~/.Rhistory
  rm ~/.viminfo
  rm ~/.local/share/fish/fish_history
  rm -rf ~/.zsh_sessions
  rm -rf ~/__pycache__
  rm -rf ~/.cache/
  rm -rf /tmp/*
  clpo
  cd
  clear
  fish
end
