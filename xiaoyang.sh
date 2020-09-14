#! /bin/bash


## ${Green_font_prefix}2.${Font_color_suffix} TCP模式(前端面板格式：你的IP或域名;10086;2;tcp;;)
##  ${Green_font_prefix}3.${Font_color_suffix} CDN模式(前端面板格式：你的域名;443;0;tls;ws;path=/|host=你的域名)
##  

echo && echo -e " sspanel v2ray一键对接脚本 ${Red_font_prefix}[v${sh_ver}]${Font_color_suffix}

————————————对接管理————————————
 ${Green_font_prefix}1${Font_color_suffix} TCP模式(前端面板格式：ip;12345;2;tcp;;server=域名)
 ${Green_font_prefix}除了1的随意数字.${Font_color_suffix} 加速脚本安装(推荐使用BBR2或BBRPlus)
 落地服务器IP;落地服务器监听端口;2;ws;;path=/xxx|server=转发服务器IP或域名|host=CDN域名|outside_port=转发服务器监听端口

————————————————————————————————" && echo
read -p "请选择对接模式(1)：" xuan
#网站地址
domain22="webapi_url=https://studycloud.today"
#mukey
mukey='webapi_mukey=xiaoyang'
#面板节点id
read -p "  1.面板里添加完节点后生成的自增ID:" sid
rid='node_id='$sid
#判断系统
os_pam(){

os=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
if [ "$os" == '"CentOS Linux"' ] ;
then
        echo "您的系统是"${os}"，开始进入脚本：(10秒之后开始)"
        sleep 10;
        yum -y install ntpdate
        timedatectl set-timezone Asia/Shanghai
        ntpdate ntp1.aliyun.com
        systemctl disable firewalld
        systemctl stop firewalld
        soga111=$(which soga)
        if [ "$soga111" != "/bin/soga" ] ;
        then
        bash <(curl -Ls https://raw.githubusercontent.com/sprov065/soga/master/install.sh)
        fi
elif [ "$os" == '"Ubuntu"' ]; 
then
        echo "您的系统是"${os}"，开始进入脚本：(10秒之后开始)"
        sleep 10;
        apt-get install -y ntp
        service ntp restart
        ufw disable
        if [ "$soga111" != "/bin/soga" ] ;
        then
        bash <(curl -Ls https://raw.githubusercontent.com/sprov065/soga/master/install.sh)
        fi
fi
}

conf(){
        sed -i "s/webapi_url=.*/${domain22}/" /etc/soga/soga.conf
        sed -i "s/webapi_mukey.*/${mukey}/" /etc/soga/soga.conf
        sed -i "s/node_id.*/${rid}/" /etc/soga/soga.conf
}

case $xuan in
        1)
        os_pam
        conf
        soga start
        echo "安装完成"
        ;;
        *) 
        wget -N --no-check-certificate "https://github.000060000.xyz/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
        ;;
esac










