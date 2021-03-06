#!/bin/bash
set -e
#使用颜色打印函数
source ~/.colorc

do_install()
{
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

#for common network
do_install net-tools

#for zephyr tools
do_install cmake
do_install python3-pip

#安装代码索引工具
do_install cscope
#安装代码标签工具
do_install ctags
#以下内容和开发有关
do_install build-essential
do_install zlib1g
do_install zlib1g-dev
do_install openssl
do_install libssl-dev
do_install libstdc++6
do_install lib32stdc++6
do_install ncurses-dev
do_install libncurses5
do_install libncurses5-dev
#do_install lib32ncurses5
#do_install lib32ncurses5-dev
do_install flex
do_install automake
do_install autoconf
do_install gawk
do_install make
do_install gettext
do_install texinfo
do_install python-dev
do_install mtd-utils
do_install binutils
do_install u-boot-tools
do_install patch
do_install zip
do_install unzip
do_install bzip2
do_install libz-dev
fo_install lib32z1
fo_install lib32z1-dev
do_install bison
do_install gperf
do_install lzop
do_install zlib1g-dev
do_install xz-utils
do_install diffstat
do_install chrpath
do_install cpio
do_install openssh-server
do_install subversion
#实施git代码管理需要以下工具
do_install git
do_install git-core
#运行QTCreator需要以下工具
do_install libgl1-mesa-dev
do_install libglu1-mesa-dev
#do_install asciidoc
sdone "Instal tools [FINISH]"
