#! /bin/bash

#网站地址定制专属
#domain=      sspanel_url: "https://xxxx"
#密钥定制专属
#mukey=      key: "xxxx"

#正式开始
#域名
read -p "  1.网站地址:" domain
domain1='     sspanel_url: "'$domain'"'
#mukey
read -p "  2.webapi对接的mukey:" key
key1='     key: "'$key'"'
#节点id
read -p "  2.面板里添加完节点后生成的自增ID:" codeid
codeid1="     node_id: $codeid"


#cloudflare 邮箱
#email="- CF_API_EMAIL="
#cloudflare密钥
#value="- CF_API_KEY="

pName=$(rpm -qa | grep docker)
if [ $? -eq 0 ]
then
        echo $xi;
else
		apt-get install -y ntp
		service ntp restart
		yum -y install ntpdate
		timedatectl set-timezone Asia/Shanghai
		ntpdate ntp1.aliyun.com
       # wget https://download.docker.com/linux/centos/7/x86_64/edge/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
        #yum install -y  containerd.io-1.2.6-3.3.el7.x86_64.rpm
        curl -fsSL https://get.docker.com | bash
        curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        chmod a+x /usr/local/bin/docker-compose
        rm -rf `which dc`
        ln -s /usr/local/bin/docker-compose /usr/bin/dc
        yum install -y git 2> /dev/null || apt install git
fi
		mkdir /root/home/v2rayx/
		cd /root/home/v2rayx/
		wget --no-check-certificate -O docker-compose.yml  https://raw.githubusercontent.com/xiaoyanggo/v2rayshell/master/docker-compose.yml
		sed -i '/sspanel_url/d' docker-compose.yml
		sed -i "10a \ $domain1" docker-compose.yml
		sed -i '12d' docker-compose.yml
		sed -i "11a \ $key1" docker-compose.yml
		sed -i '15d' docker-compose.yml
		sed -i "14a \ $codeid1" docker-compose.yml
		service docker restart
		dc up -d
		systemctl stop firewalld.service






