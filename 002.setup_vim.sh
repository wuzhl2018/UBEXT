#!/bin/bash
set -e
source ~/.colorc
export THINGS_DIR=002.setup_vim.things
mainproc()
{
	sinfo "sudo apt-get install -y vim"
	sudo apt-get install -y vim > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		serro "sudo apt-get install -y vim > /dev/null 2>&1 [ERROR]"
		return 1
	fi
	sdone "sudo apt-get install -y vim > /dev/null 2>&1 [DONE]"
	pwarn "try: cp -rf $THINGS_DIR/dugi.vim     ~/.vim"
	pwarn "try: cp -rf $THINGS_DIR/dugi.viminfo ~/.viminfo"
	pwarn "try: cp -rf $THINGS_DIR/dugi.vimrc   ~/.vimrc"
	cp -rf $THINGS_DIR/dugi.vim     ~/.vim
	cp -rf $THINGS_DIR/dugi.viminfo ~/.viminfo
	cp -rf $THINGS_DIR/dugi.vimrc   ~/.vimrc
	sdone "setup vim [OK]"
}
mainproc $@
