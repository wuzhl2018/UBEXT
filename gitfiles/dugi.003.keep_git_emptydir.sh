#!/bin/bash
#作者:DUGIGEEK
#日期:2018.12.08
#描述:git的配置

#使用颜色打印函数
source ~/.colorc

#帮助函数
help ()
{
	pwarn "usage: $0 [dirname]"
}

if [ -z $1 ]; then
	perro "Please set directory name!"
	help
	exit 1
fi

CKC_DIR_NAME=$1
if [ ! -e ${CKC_DIR_NAME} ]; then
	perro "Check directory: ${CKC_DIR_NAME} not exist [ERROR]"
	exit 1
fi
EMP_DIR_LIST=$(find ${CKC_DIR_NAME} -type d -empty)
pinfo "Get empty directory list:"
for adir in ${EMP_DIR_LIST};
do
	pdone "$adir"
done

#创建一个gitkeep隐藏文件
GITKEEP_LINE1="# Ignore everything in this directory"
GITKEEP_LINE2="*"
GITKEEP_LINE3="# Except this file !.gitkeep"

if [ -e ./.gitkeep.raw ]; then
	rm -rf ./.gitkeep.raw
fi

echo "${GITKEEP_LINE1}" >  ./.gitkeep.raw
echo "${GITKEEP_LINE2}" >> ./.gitkeep.raw
echo "${GITKEEP_LINE3}" >> ./.gitkeep.raw

for adir in ${EMP_DIR_LIST};
do
	cp -rf ./.gitkeep.raw  ${adir}/.gitkeep
	if [ $? -eq 0 ]; then
		pdone "set ${adir} as git keep [OK]"
	else
		perro "set ${adir} as git keep [ERROR]"
	fi
done
rm -rf ./.gitkeep.raw
pinfo "Do keep git empty directory [FINISH]"
