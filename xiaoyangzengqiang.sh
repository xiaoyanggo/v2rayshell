#! /bin/bash

echo && echo -e " sspanel v2ray一键对接脚本 ${Red_font_prefix}[v${sh_ver}]${Font_color_suffix}
        -- 小杨 | 加油 --

————————————对接管理————————————
 ${Green_font_prefix}1.${Font_color_suffix} WS-TLS模式(前端面板格式：你的域名;443;0;tls;ws;path=/|host=你的域名)
 ${Green_font_prefix}2.${Font_color_suffix} TCP模式(前端面板格式：你的IP或域名;10086;2;tcp;;)
 ${Green_font_prefix}3.${Font_color_suffix} CDN模式(前端面板格式：你的域名;443;0;tls;ws;path=/|host=你的域名)
————————————————————————————————" && echo
read -p "请选择对接模式(1,2,3)：" xuan
xi=" "
xi2=" "
#网站地址
domain='    "panelUrl": "http://poli23.icu/",'
#mukey
mukey='"panelKey": "xiaoyang",'
#面板节点id
read -p "  1.面板里添加完节点后生成的自增ID:" sid
rid='"nodeId": '$sid','
#cloudflare 邮箱
email="- CF_Email=l2690329987@gmail.com"
#cloudflare密钥
value="- CF_Key=790a5ab094267d77f740e17aab0f21646f625"
#授权密钥
key='    "license_key": "LP+BAwEBB0xpY2Vuc2UB/4IAAQMBBERhdGEBCgABAVIB/4QAAQFTAf+EAAAACv+DBQEC/4YAAAD/2f+CAW57Ikhvc3RNZDUiOiI2MzkxRkFDQzcyMTcyODMxOTY1QzM5MEJBNTExRDVDOCIsIkVuZCI6IjIwMjEtMDItMjZUMjI6Mzc6NTQuNjY1MTk2KzA4OjAwIiwiSXNXSE1DU0xpY2Vuc2UiOmZhbHNlfQExAhS09FXSdZhsZXPTdALlhBzbPfmFUdsVkGdDXDw5UUMr7UeBaFYkEd6uUbQ+ueLivQExAk9Z5c6cbuvtdIf/mEpN1Ju8mZj8LNplLm97rx1mV14loMwJPySUR5du8yItdX4bZwA=",'


pName=$(rpm -qa | grep docker)
if [ $? -eq 0 ]
then
        echo $xi;
else
		yum -y install ntpdate
		timedatectl set-timezone Asia/Shanghai
		ntpdate ntp1.aliyun.com
		yum clean all
		yum install docker-ce
		wget https://download.docker.com/linux/centos/7/x86_64/edge/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
		yum install -y  containerd.io-1.2.6-3.3.el7.x86_64.rpm
		yum clean all
		yum install docker-ce
        curl -fsSL https://get.docker.com | bash
        curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        chmod a+x /usr/local/bin/docker-compose
        rm -rf `which dc`
        ln -s /usr/local/bin/docker-compose /usr/bin/dc
fi
#pNamea=$(rpm -qa | grep git)
#if [ $? -eq 0 ]
#then
#        echo $xi2
#else

yum install -y git 2> /dev/null || apt install git
        
#fi

if [ ! -d "/root/v2ray-poseidon" ]; then
	cd /root
	git clone https://github.com/ColetteContreras/v2ray-poseidon.git
fi




case $xuan in
	1)
		#ws-tls模式
		read -p "  2.CF上面解析的域名：" cf
		cf1="- CERT_DOMAIN="$cf
		cd /root/v2ray-poseidon/docker/sspanel/ws-tls/
		sed -i '/license_key/d' config.json
		sed -i "/\"panel\": \"sspanel-webapi\",/ a\\$key" config.json
		sed -i '/"panelUrl":/d' config.json
		sed -i "/\"checkRate\": 60,/ a\\$domain" config.json
		sed -i '/"panelKey":/d' config.json
		sed -i "8a\    $mukey" config.json
		sed -i '/\"nodeId\":/d' config.json
		sed -i "4a \    $rid" config.json
		sed -i "/-\ CF_Email=/d" docker-compose.yml
		sed -i "/-\ CF_Key=/d" docker-compose.yml
		sed -i "27a \      $value" docker-compose.yml
		sed -i "27a \      $email" docker-compose.yml
		sed -i "/-\ CERT_\DOMAIN/d" docker-compose.yml
		sed -i "25a \      $cf1" docker-compose.yml
		service docker restart
		dc up -d
		;;
	2)
		#tcp模式
		read -p "  2.tcp端口：" port
		port1='     - "'$port':'$port'"'
		port2='    "port": '$port','
		cd /root/v2ray-poseidon/docker/sspanel/tcp
		sed -i '/license_key/d' config.json
		sed -i "/\"panel\": \"sspanel-webapi\",/ a\\$key" config.json
		sed -i '/"panelUrl":/d' config.json
		sed -i "/\"checkRate\": 60,/ a\\$domain" config.json
		sed -i '/"panelKey":/d' config.json
		sed -i "8a\    $mukey" config.json
		sed -i '/\"nodeId\":/d' config.json
		sed -i "4a \    $rid" config.json
		sed -i '22d' config.json
		sed -i "21a \ $port2" config.json
		sed -i '9d' docker-compose.yml
		sed -i "8a \ $port1" docker-compose.yml
		service docker restart
		dc up -d
		;;
	3)
		#CDN模式
		cd /root/v2ray-poseidon/docker/sspanel/ws
		sed -i '/license_key/d' config.json
		sed -i "/\"panel\": \"sspanel-webapi\",/ a\\$key" config.json
		sed -i '/"panelUrl":/d' config.json
		sed -i "/\"checkRate\": 60,/ a\\$domain" config.json
		sed -i '/"panelKey":/d' config.json
		sed -i "8a\    $mukey" config.json
		sed -i '/\"nodeId\":/d' config.json
		sed -i "4a \    $rid" config.json
		service docker restart
		dc up -d
		;;
esac
systemctl stop firewalld.service




