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
	sinfo "   $0 本地仓库名称 远程仓库拥有者@远程仓库IP:远程仓库名称"
	sinfo "使用示例:"
	sinfo "   $0 project1 gitown@192.168.1.100:project1.git"
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

	sinfo "注意: 推送远程仓库前需要以下操作:"
	sinfo "1.需要在本地执行:ssh-keygen -t rsa 产生公钥"
	sinfo "2.将~/.ssh目录产生的.pub公钥文件递交到远程仓库进入gitosis管理"
	sinfo "3.请求gitosis仓库管理者新增当前项目并设置权限"

	git push origin master
}

mainproc $@


