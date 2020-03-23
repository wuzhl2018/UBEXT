#!/bin/bash
#作者:DUGIGEEK
#日期:2018.12.08
#描述:该脚本用于增加颜色打印函数和优化命令交互终端

#部署颜色函数
if [ -f ~/.colorc ]; then
	#删除旧的函数
	rm ~/.colorc
fi

export THINGS_DIR=001.setup_shell.things

#第一次安装显示各个函数的颜色效果
source ${THINGS_DIR}/dugi.colorc

#拷贝并且重命名文件
cp -rf $THINGS_DIR/dugi.colorc   ~/.colorc
if [ $? -ne 0 ]; then
	perro "failed install dugi.colorc [ERROR]"
else
	pdone "finish install dugi.colorc [OK]"
fi

#备份当前.bashrc
cp -rf ~/.bashrc ~/.bashrc.old

#部署控制台脚本
cp -rf $THINGS_DIR/dugi.bashrc   ~/.bashrc
if [ $? -ne 0 ]; then
	echo "failed install dugi.bashrc [ERROR]"
else
	echo "finish install dugi.bashrc [OK]"
fi

