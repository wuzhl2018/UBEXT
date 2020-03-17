#!/bin/bash
show_usage()
{
	echo "使用说明:"
	echo "该脚本用于自动创建用户和同名分组"
	echo "$0 用户名称"
	return 1
}

mainproc()
{
	echo "create_user:[开始]>>>>>>>>>>>>>>>>>>>>>>>>>>"
	if [ $# -ne 1 ]; then
		echo "输入参数错误!"
		show_usage
		return 1
	fi

	echo "创建个人分组..."
	sudo groupadd $1
	if [ $? -ne 0 ]; then
		echo "[失败]"
		return 1
	fi
	echo "[成功]"

	echo "创建用户及其相关信息..."
	sudo useradd -m -d /home/$1 -g $1 -s /bin/bash -r $1
	if [ $? -ne 0 ]; then
		echo "[失败]"
		return 1
	fi
	echo "[成功]"
	
	echo "创建用户登陆密码..."
	sudo passwd $1
	if [ $? -ne 0 ]; then
		echo "[失败]"
		return 1
	fi
	echo "[成功]"
	
	echo "将用户添加到更多的分组..."
	sudo usermod -a -G adm,cdrom,sudo,plugdev,sambashare $1
	if [ $? -ne 0 ]; then
		echo "[失败]"
		return 1
	fi
	echo "[成功]"

	id $1
	echo "create_user:[完成]<<<<<<<<<<<<<<<<<<<<<<<<<<"
	return 0
}

mainproc $@
if [ $? -ne 0 ]; then
	echo "create_user:[失败]<<<<<<<<<<<<<<<<<<<<<<<<<<"
fi
