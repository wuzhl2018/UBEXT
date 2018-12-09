#!/bin/bash
#作者:DUGIGEEK
#日期:2018.12.08
#描述:使用国内软件源

#使用颜色打印函数
source ~/.colorc

sudo cp aptfiles/sources.list /etc/apt/
pdone "Update sources.list [OK]"

sudo apt-get update
if [ $? -eq 0 ]; then
	perro "Do apt-get update [ERROR]"
else
	pdone "Do apt-get update [OK]"
fi

sudo apt-get upgrade
if [ $? -eq 0 ]; then
	perro "Do apt-get upgrade [ERROR]"
else
	pdone "Do apt-get upgrade [OK]"
fi
