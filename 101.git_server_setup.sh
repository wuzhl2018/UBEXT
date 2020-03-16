#!/bin/bash

#使用颜色打印函数
source ~/.colorc

#设置GIT仓库拥有者名称
export ownname=gitown

#设置GIT仓库管理者名称
export mgrname=$(whoami)

#快速安装软件
do_install()
{
	swarn "安装 $1 [开始]"
	sudo apt-get install -y $1 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
		sdone "安装 $1 [完成]"
	else
		serro "安装 $1 [失败]"
		exit 1
	fi
}

#安装必须工具
install_tools()
{
	do_install git
	do_install git-core 
	do_install openssh-server 
	do_install openssh-client
	do_install python-setuptools

	if [ ! -d gitosis ]; then
		sinfo "下载gitosis..."
		git clone https://github.com/res0nat0r/gitosis.git  > /dev/null 2>&1
		if [ $? -ne 0 ]; then
			serro "[失败]"
			exit 1
		fi
		sdone "[成功]"

		echo "安装gitosis..."
		cd gitosis
		sudo python setup.py install > /dev/null 2>&1
		if [ $? -ne 0 ]; then
			serro "[失败]"
			cd - > /dev/null 2>&1
			exit 1
		fi
		cd - > /dev/null 2>&1
		sdone "[成功]"
	fi
	return 0
}

#设置git仓库拥有者信息
setup_gitown_info()
{
	ownname=${ownownname}

	echo "创建git仓库拥有者分组..."
	sudo userdel  $ownname > /dev/null 2>&1
	sudo groupdel $ownname > /dev/null 2>&1
	sudo groupadd $ownname
	if [ $? -ne 0 ]; then
		serro "[失败]"
		return 1
	fi
	sdone "[成功]"

	echo "创建git仓库拥有者账号..."
	sudo useradd -m -d /home/$ownname -g $ownname -s /bin/bash -r $ownname
	if [ $? -ne 0 ]; then
		serro "[失败]"
		return 1
	fi
	sdone "[成功]"
	
	echo "创建git仓库拥有者密码..."
	sudo passwd $ownname
	if [ $? -ne 0 ]; then
		serro "[失败]"
		return 1
	fi
	sdone "[成功]"
	
	echo "分配git仓库拥有者分组..."
	sudo usermod -a -G sudo $ownname
	if [ $? -ne 0 ]; then
		serro "[失败]"
		return 1
	fi
	sdone "[成功]"

	echo "拷贝基础文件..."
	sudo cp -rf userfiles/dugi.colorc   /home/$ownname/.colorc
	sudo cp -rf /home/$ownname/.bashrc  /home/$ownname/.bashrc.old
	sudo cp -rf userfiles/dugi.bashrc   /home/$ownname/.bashrc

	echo "请在git仓库拥有者执行以下设置:"
	echo "cd ~"
	echo "git config --global user.ownname  $ownname"
	echo "git config --global user.email    $ownname@qq.com"
	echo "git config --global core.quotepath false"
	echo "git config --global core.quotepath false"
	echo "sudo rm ./keys.ssh.$mgrname -rf"
	echo "sudo cp /tmp/keys.ssh.$mgrname ./ -rf"
	echo "sudo chown -R $ownname:$ownname keys.ssh.$mgrname"
	echo "sudo -H -u $ownname gitosis-init < ./keys.ssh.$mgrname/id_rsa.pub"
	echo "成功后会在/home/$ownname/目录下产生repositories目录"
	echo ""
	echo "登陆git仓库拥有者..."
	echo "su $ownname"
	su $ownname
}

#设置git管理者信息
setup_gitmgr_info()
{
	#默认当前用户作为git管理者
	#设置当前用户的git名称和邮箱
	name=${mgrname}
	mail=${mgrname}@qq.com

	#拷贝一些脚本作为日常git管理使用
	sudo cp gitfiles/dugi.*.sh /usr/bin/
	sudo chmod 777 /usr/bin/dugi.*.sh
	pdone "Config git [完成]"

	#写入用户信息
	git config --global user.name "${name}"
	pdone "Setup git user name: ${name} [完成]"
	git config --global user.email "${mail}"
	pdone "Setup git user email: ${mail} [完成]"

	#避免中文乱码
	git config --global core.quotepath false

	return 0
}

#设置git管理者公钥
create_gitmgr_keys()
{
	ssh-keygen -t rsa
	sudo cp ~/.ssh  /tmp/keys.ssh.$(whoami) -rf
}
show_usage()
{ 
	sinfo "--------------------------------------------------"
	sinfo "使用说明:"
	sinfo "该脚本用于构建GIT服务器"
	sinfo "--------------------------------------------------"
	sinfo "$0 01  安装必须的工具"
	sinfo "$0 02  管理者$mgrname的git设置配置"
	sinfo "$0 03  管理者$mgrname的ssh公钥配置"
	sinfo "$0 04  拥有者$ownname的git设置配置"
	sinfo "--------------------------------------------------"
}
mainproc()
{
	if [ "x$1" = "x01" ]; then
		install_tools
	elif [ "x$1" = "x02" ]; then
		setup_gitmgr_info
	elif [ "x$1" = "x03" ]; then
		create_gitmgr_keys
	elif [ "x$1" = "x04" ]; then
		setup_gitown_info
	else
		show_usage
		return
	fi

}
mainproc $@
