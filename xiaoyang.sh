#! /bin/bash
hell0="        欢迎使用sspanelv2ray后端对接脚本"
xi="docker已经安装了"
xi2="git已经安装了"
echo $hell0
domain='    "panelUrl": "http://poli23.icu/",'
mukey='"panelKey": "xiaoyang",'
read -p "  1.面板里添加完节点后生成的自增ID:" sid
read -p "  2.CF上面解析的域名：" cf
cf1="command: tls cloudflare "$cf
rid='"nodeId": '$sid','
email="- CF_API_EMAIL=l2690329987@gmail.com"
value="- CF_API_KEY=790a5ab094267d77f740e17aab0f21646f625"
commd="command: tls cloudflare yinghuayunv2rayxjp2.paolu.online"
key='    "license_key": "LP+BAwEBB0xpY2Vuc2UB/4IAAQMBBERhdGEBCgABAVIB/4QAAQFTAf+EAAAACv+DBQEC/4YAAAD/2f+CAW57Ikhvc3RNZDUiOiI2MzkxRkFDQzcyMTcyODMxOTY1QzM5MEJBNTExRDVDOCIsIkVuZCI6IjIwMjEtMDItMjZUMjI6Mzc6NTQuNjY1MTk2KzA4OjAwIiwiSXNXSE1DU0xpY2Vuc2UiOmZhbHNlfQExAhS09FXSdZhsZXPTdALlhBzbPfmFUdsVkGdDXDw5UUMr7UeBaFYkEd6uUbQ+ueLivQExAk9Z5c6cbuvtdIf/mEpN1Ju8mZj8LNplLm97rx1mV14loMwJPySUR5du8yItdX4bZwA=",'
pName=$(rpm -qa | grep docker)
if [ $? -eq 0 ]
then
        echo $xi;
else
        curl -fsSL https://get.docker.com | bash
        curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        chmod a+x /usr/local/bin/docker-compose
        rm -rf `which dc`
        ln -s /usr/local/bin/docker-compose /usr/bin/dc
fi

pNamea=$(rpm -qa | grep git)
if [ $? -eq 0 ]
then
        echo $xi2
else

        yum install git 2> /dev/null || apt install git
        
fi

if [ ! -d "/root/v2ray-poseidon" ]; then
	git clone https://github.com/ColetteContreras/v2ray-poseidon.git
fi


cd /root/v2ray-poseidon/docker/sspanel/ws-tls/
sed -i '/license_key/d' config.json
sed -i "/\"panel\": \"sspanel-webapi\",/ a\\$key" config.json

sed -i '/"panelUrl":/d' config.json
sed -i "/\"checkRate\": 60,/ a\\$domain" config.json

sed -i '/"panelKey":/d' config.json
sed -i "8a\    $mukey" config.json


#sed -i "s/\"nodeId\": 1,/$rid/g" config.json
sed -i '/\"nodeId\":/d' config.json
sed -i "4a \    $rid" config.json

#sed '/l2690329987/d' docker-compose.yml
sed -i "/-\ CF_API_EMAIL=/d" docker-compose.yml
sed -i "/-\ CF_API_KEY=/d" docker-compose.yml
sed -i "15a \      $value" docker-compose.yml
sed -i "15a \      $email" docker-compose.yml
#sed -i "s/- CF_API_EMAIL=/$email/g" docker-compose.yml
#sed -i "s/- CF_API_KEY=/$value/g" docker-compose.yml

sed -i "/command:\ tls\ cloudflare/d" docker-compose.yml
sed -i "24a \    $cf1" docker-compose.yml

service docker restart

dc up -d

systemctl stop firewalld.service




