#!/bin/bash
# Detect OS
if grep -qs "ubuntu" /etc/os-release; then
	os="ubuntu"
	os_version=$(grep 'VERSION_ID' /etc/os-release | cut -d '"' -f 2 | tr -d '.')
elif [[ -e /etc/debian_version ]]; then
	os="debian"
	os_version=$(grep -oE '[0-9]+' /etc/debian_version | head -1)
elif [[ -e /etc/centos-release ]]; then
	os="centos"
	os_version=$(grep -oE '[0-9]+' /etc/centos-release | head -1)
elif [[ -e /etc/fedora-release ]]; then
	os="fedora"
	os_version=$(grep -oE '[0-9]+' /etc/fedora-release | head -1)
else
	echo "your os is not supporteed yet!"
	exit
fi
#check python version and installation
haspython=$(python3.7 -V 2>&1 | grep -Po '(?<=Python )(.+)')
#install python 
installpython() {
 yum install gcc openssl-devel bzip2-devel libffi-devel sqlite-devel -y && cd /usr/src && wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz && tar xzf Python-3.7.3.tgz && cd Python-3.7.3 && ./configure --enable-loadable-sqlite-extensions && make && make install
}
#mtproto proxy installation
installmtprotoproxy() {
 yum install epel-release -y && yum install tmux bind-utils screen zip git htop wget -y
 if [[ -z "$haspython" ]]
 then
  installpython
 fi
  echo "installing mtproto proxy server..."
  git clone -b stable https://github.com/alexbers/mtprotoproxy
  echo "done! now run this command:"
  echo "cd mtprotoproxy && tmux new -s proxy and then python3.7 mtprotoproxy.py"
}
#bot requierment installation
installbot() {
read -p "do you need redis? [y/n]" ANS
 if [ "$ANS" == "y" ];then
  yum install epel-release -y && yum install redis tmux bind-utils screen zip git htop wget -y && systemctl enable redis && systemctl start redis
 else
  yum install epel-release -y && yum install tmux bind-utils screen zip git htop wget -y
 fi
}
#main
if [ "$os" == "centos" ];then
read -p "do you want to install mtproto proxy? [y/n]" ANS
if [ "$ANS" == "y" ];then
 installmtprotoproxy
elif [ "$ANS" == "n" ];then
read -p "do you want to install bot requierments? [y/n]" ANS
if [ "$ANS" == "y" ];then
 installbot
  if [[ -z "$haspython" ]];then
  installpython
 fi
fi
fi
else
 echo "your os is not supported yet!"
fi
