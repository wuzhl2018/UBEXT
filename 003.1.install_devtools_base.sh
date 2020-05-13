#!/bin/bash
set -e
#使用颜色打印函数
source ~/.colorc

do_install()
{
	swarn "Install $1 [CHECK]"
	depends_str=$(apt-cache depends $1 | grep Depends | awk '{print $2}')
	if [ -n "${depends_str}" ]; then
		snote "Depends:"
		sinfo "${depends_str}"
	else
		snote "Depends: nothing"
	fi
	swarn "Install $1 [START]"
	sudo apt-get install -y $1 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
		sdone "Install $1  [OK]"
	else
		serro "Install $1  [ERROR]"
		exit 1
	fi
}

fo_install()
{
	swarn "Install $1 [START]"
    sudo apt-get install -y $1 --force-yes > /dev/null 2>&1
    if [ $? -eq 0 ]; then
		sdone "Install $1  [OK]"
	else
		serro "Install $1  [ERROR]"
		exit 1
	fi
}

swarn "Instal tools [START]"
do_install vim
do_install cscope
do_install ctags
do_install make
do_install automake
do_install autoconf
do_install build-essential
do_install ncurses-dev
do_install flex
do_install bison
do_install gperf
do_install curl
sdone "Instal tools [FINISH]"
