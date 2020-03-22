#!/bin/bash
#作者:DUGIGEEK
#日期:2018.12.08
#描述:git的配置

#使用颜色打印函数
source ~/.colorc

#帮助函数
show_usage()
{
	sinfo "使用说明:"
	sinfo "该脚本用于创建并初始化本地仓库并推送到远程仓库:"
	sinfo "   $0 本地仓库名称 远程仓库拥有者@远程仓库IP:远程仓库名称(不用加.git后缀)"
	sinfo "使用示例:"
	sinfo "   $0 project1 gitown@192.168.1.100:project1"
	show_note
}

#提示函数
show_note()
{
	swarn "特别注意: "
	swarn "新建并推送到远程仓库前需要做以下操作:"
	swarn "1.开发者在本地执行:ssh-keygen -t rsa (产生公钥.pub文件存放在~/.ssh目录)"
	swarn "2.开发者将~/.ssh目录的公钥.pub文件发送给仓库管理员"
	swarn "3.开发者告知仓库管理员需要新建的项目名称(例如project1)"
	swarn "4.开发者等待仓库管理员打开权限"
	swarn "5.获得权限后方可执行该脚本"
}

mainproc()
{
	#检测参数个数
	if [ $# -ne 2 ]; then
		serro "参数错误!"
		show_usage $@
		return 1
	fi

	#检测本地仓库名称
	if [ -d  ./$1 ]; then
		serro "本地仓库: $1 已经存在!"
		show_usage $@
		return 1
	fi
	
	#本地仓库名称
	LOCAL_GITSRC_NAME=$1

	#远程仓库路径
	REMOTE_GITOWN_PATH=$2

	sinfo "开始创建本地仓库..."
	mkdir ./$LOCAL_GITSRC_NAME
	cd ./$LOCAL_GITSRC_NAME

	sinfo "初始化git仓库..."
	git init

	sinfo "创建.local_git_init文件表示属于本地初始化项目"
	echo yes >  .local_git_init

	sinfo  "递交初始化文件..."
	git add -A .  > /dev/null 2>&1
	git commit -am "add .local_init_git"

	sinfo "添加远程仓库..."
	git remote add origin $REMOTE_GITOWN_PATH
	if [ $? -ne 0 ]; then
		serro "添加远程仓库: ${REMOTE_GITOWN_PATH} [失败]"
	else
		sdone "添加远程仓库: ${REMOTE_GITOWN_PATH} [成功]"
	fi
	sdone "创建完毕"
	
	sinfo "推送本地仓库到远程仓库...[开始]"
	git push origin master
	sdone "推送本地仓库到远程仓库...[完成]"
}

mainproc $@


