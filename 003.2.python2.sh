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
	#sudo apt-get install -y $1 > /dev/null 2>&1
	sudo apt-get install -y $1
    if [ $? -eq 0 ]; then
		sdone "Install $1  [OK]"
	else
		serro "Install $1  [ERROR]"
		exit 1
	fi
}

do_python2_install()
{
	swarn "Instal python2 [START]"
	do_install python2
	sdone "Instal python2 [FINISH]"
	swarn "check  python2 version [START]"
	python2 --version
	swarn "check available python verion"
	ls /usr/bin/python*
	swarn "check current python alternatives before settings"
	set +e
	sudo update-alternatives --list python
	set -e
	swarn "set python2 alternatives index as 1"
	sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 1
	swarn "set python3 alternatives index as 2"
	sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 2
	swarn "check current python alternatives after settings"
	sudo update-alternatives --list python
	sdone "plsease choose default phyon ..."
	sudo update-alternatives --config python
}

do_pip2_install()
{
	echo "sudo python2 pip2fiels/get-pip.py"
	sudo python2 pip2files/get-pip.py
}

do_python2_install
do_pip2_install


