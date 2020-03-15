#!/bin/bash

show_usage()
{
	echo "使用说明:"
	echo "修改主机名称"
	echo "$0 主机名称"
	return 1
}

mainproc()
{
	echo "setup_hostname:[开始]>>>>>>>>>>>>>>>>>>>>>>>>>>"
	if [ $# -ne 1 ]; then
		echo "输入参数错误!"
		show_usage
		return 1
	fi

	hostnamectl set-hostname $1
	if [ $? -ne 0 ]; then
		echo "[失败]"
		return 1
	fi
	echo "[成功]"

	echo "setup_hostname:[完成]<<<<<<<<<<<<<<<<<<<<<<<<<<"
	return 0
}

mainproc $@
if [ $? -ne 0 ]; then
	echo "setup_hostname:[失败]<<<<<<<<<<<<<<<<<<<<<<<<<<"
fi
