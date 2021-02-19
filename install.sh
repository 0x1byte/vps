#!/bin/bash
read -p "do you want to install mtproto proxy? [y/n]" ANS
if [ "$ANS" == "y" ];then
 yum install epel-release -y && yum install tmux bind-utils screen zip git htop wget -y
 yum install gcc openssl-devel bzip2-devel libffi-devel sqlite-devel -y && cd /usr/src && wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz && tar xzf Python-3.7.3.tgz && cd Python-3.7.3 && ./configure --enable-loadable-sqlite-extensions && make && make install
 git clone -b stable https://github.com/alexbers/mtprotoproxy && mv mtprotoproxy proxy && cd proxy
elif [ "$ANS" == "n" ];then
read -p "do you want to install bot requierments? [y/n]" ANS
if [ "$ANS" == "y" ];then
 read -p "do you need redis? [y/n]" ANS
 if [ "$ANS" == "y" ];then
  yum install epel-release -y && yum install redis tmux bind-utils screen zip git htop wget -y && systemctl enable redis && systemctl start redis
 else
  yum install epel-release -y && yum install tmux bind-utils screen zip git htop wget -y
 fi
  yum install gcc openssl-devel bzip2-devel libffi-devel sqlite-devel -y && cd /usr/src && wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz && tar xzf Python-3.7.3.tgz && cd Python-3.7.3 && ./configure --enable-loadable-sqlite-extensions && make && make install
fi
fi
