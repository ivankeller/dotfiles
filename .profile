if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

#function proml
#{
#        case $TERM in
#                xterm*) local TITLEBAR='\[\033]0;\d \t \w\007\]' ;;
#                *)      local TITLEBAR='' ;;
#        esac
#PS1="${TITLEBAR}\
#\[\033[31m\]
#CCA\[\033[39m\][\w]\
#\n>"
#PS2='$ '
#PS4='+ '
#}
#proml
#unset proml

export LC_NUMERIC="en_US.UTF-8"

export TERM="xterm-256color"

######

export APA_DATA="/media/apa03/BACKUP/apa/data"
export APA_REPO="/media/apa03/BACKUP/apa/apalab"

export CYGH="/media/apa03/WINDOWS/cygwin64/home/apa03/"

######

if [ -e ~/.git-completion.bash ]
then
  source ~/.git-completion.bash
elif [ -e /bin/git-completion.bash ]
then
  source /bin/git-completion.bash
fi

dyw ()
{
        diff -yW$(stty size | awk '{print $2}') $1 $2
}

cds ()
{
        cd /media/apa03/BACKUP/
}

v ()
{
        gvim --servername VIM "$@"
}

alias vi=vim

gits ()
{
        git status
}

findColumn ()
{
  if [ $# -ne 3 ]
  then
    echo "Illegal number of parameters"
    echo "1: file, 2: separator, 3: pattern"
  fi
  i=0
  for j in $(head -1 $1 | tr "$2" " ")
  do echo $j $i; i=$(($i+1))
  done | grep "$3"
}


HISTSIZE=10000
HISTFILESIZE=10000

export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/"
export PATH=$PATH:~/services/mongodb-linux-x86_64-ubuntu1404-3.2.10/bin/

export http_proxy=http://lhvbdab8:1234
export https_proxy=https://lhvbdab8:1234

alias ccaetl="cd /data/projects/cca-etl/"

export HADOOP_USER_NAME=adst
export MESOS_NATIVE_JAVA_LIBRARY=/usr/local/lib/libmesos.so
export JAVA_OPTS="$JAVA_OPTS -Dhttp.proxyHost=lhvbdab8 -Dhttp.proxyPort=1234 -Dhttp.nonProxyHosts=lhvbdab8"
