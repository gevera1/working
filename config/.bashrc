# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export P4PORT=qctp401:1666
export P4USER=agevero
export SHELL=/bin/bash

# VCE setup
export PATH="$PATH:/prj/qct/asw/qctss/linux/bin/vce"
alias vce='python /prj/qct/asw/qctss/linux/bin/vce/vce.py'

# LLVM for Linux
export PATH="$PATH:/pkg/qct/software/llvm/release/arm/14.0.0/bin/clang"

# Compiler tools setup
export PATH="$PATH:/pkg/qct/qctss/linux/bin"

export PATH="/pkg/qct/software/perforce/bin/:$PATH"
export PATH="$PATH:/prj/qct/asw/crmbuilds/"


# KW
export PATH="$PATH:/prj/qct/asw/SABin/Linux/Klocwork/User/bin"

# engtools
export PATH="$PATH:/prj/qct/qctdata/CoreBSPTarget/tools/eng/2.x/latest"

# p4v
export PATH="/pkg/qct/software/perforce/current:$PATH"

# Personal scripts
export PATH="$PATH:/usr2/agevero/.local/bin"
function log() {
  if grep -Fxq "$PWD/$@" $LOGDIRR/editlogs.txt
  then
    printf "You've logged this file already!\nIf you wish to edit, use vim.\n"
  else
    echo "$PWD/$@" >> $LOGDIRR/editlogs.txt
    vim $@
  fi
}

# Make-life-easy aliases
alias cb="cd /local/mnt/workspace/builds"
alias cls="clear"
alias ch="cd /local/mnt/workspace"

alias oem="cd /local/mnt/workspace/builds/kailua/220817_agevero_BOOT.MXF.2.1-00688-KAILUA-1_01"
alias timetick="cd /local/mnt/workspace/builds/pinnacles/engg/221207_agevero_MPSS.DE.5.0-01200.2-PINNACLES_CORE_TEST-1_01/modem_proc/core/systemdrivers/timetick/"

dc()    { for i in $(seq 1 $1); do cd ../; done }
        
p4x()   { p4v -p $P4PORT -u $P4USER -c $P4USER."$1"; }

# SSL issues (temp?)
# export USE_PCM_CUSTOM_URL=http://csds/
# export PWAPI_URL=http://pw.qualcomm.com/tools/interface_json.php
# export FINDBUILD_OVERRIDE_SITE=http://crmbuild.qualcomm.com/crmbuild.svc?wsdl

# repo (CVP/Git) stuff
# export PATH="$PATH:~/.bin"

cd /local/mnt/workspace/builds

fortune | cowsay

# export DISPLAY=$(ip route list default | awk '{print $3}'):0
# export LIBGL_ALWAYS_INDIRECT=1
