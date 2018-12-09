#!/bin/bash
#作者:DUGIGEEK
#日期:2018.12.08
#描述:该脚本用于增加颜色打印函数和优化命令交互终端
#备份当前.bashrc
cp -rf ~/.bashrc ~/.bashrc.old
#部署控制台脚本
cp -rf userfiles/dugi.bashrc   ~/.bashrc
#部署颜色函数
cp -rf userfiles/dugi.colorc   ~/.colorc
