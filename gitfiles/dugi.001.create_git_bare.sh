#!/bin/bash
#作者:DUGIGEEK
#日期:2018.12.08
#描述:创建一个git源码空库

#使用颜色打印函数
source ~/.colorc

#需要给定源码库名称
if [ -z $1 ]; then
	pwarn "请输入git基础库名称"
	exit 1
fi

#仓库路径
git_repo_rpath=/home/gitown/repositories
#仓库用户
git_repo_admin=gitown

#如果源码顶层目录不存在则创建
if [ ! -d ${git_repo_rpath} ]; then
	sudo mkdir ${git_repo_rpath}
	sudo chown -R ${git_repo_admin}:${git_repo_admin} ${git_repo_rpath}
	pdone "成功创建git仓库目录:${git_repo_rpath}"
fi

#开始创建源码空库
cd ${git_repo_rpath}
sudo git init --bare $1.git
if [ $? -ne 0 ]; then
	perro "创建git基础仓库$1.git [失败]"
	exit 1
fi
pdone "创建git基础仓库$1.git [完成]"

#将创建的源码空库所有者修改为git
sudo chown -R ${git_repo_admin}:${git_repo_admin} $1.git

#回到先前目录
cd - > /dev/null
