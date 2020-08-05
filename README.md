# v2rayshell

## v2ray p版本脚本：

    wget --no-check-certificate -O xiaoyangzengqiang.sh https://raw.githubusercontent.com/xiaoyanggo/v2rayshell/master/xiaoyangzengqiang.sh && chmod +x xiaoyangzengqiang.sh && ./xiaoyangzengqiang.sh

## v2ray rico版本

    mkdir v2ray-agent  &&   cd v2ray-agent && curl https://raw.githubusercontent.com/xiaoyanggo/v2rayshell/master/v2xy.sh -o v2xy.sh &&  chmod +x v2xy.sh &&  bash v2xy.sh
## rico 版本 docker 对接：
    #添加节点
    地址;端口;2;ws;;path=/img|host=域名
    #安装加速
    yum -y install wget
    wget -N --no-check-certificate "https://github.000060000.xyz/tcpx.sh" && chmod +x tcpx.sh && ./tcpx.sh
    #同步时间关闭防火墙
    yum -y install ntpdate
    timedatectl set-timezone Asia/Shanghai
    ntpdate ntp1.aliyun.com
    systemctl disable firewalld
    systemctl stop firewalld
    #安装Docker容器
    curl -fsSL https://get.docker.com | bash
    curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod a+x /usr/local/bin/docker-compose
    rm -f which dc 
    ln -s /usr/local/bin/docker-compose /usr/bin/dc
    #启动docker容器
    systemctl start docker
    service docker start
    systemctl enable docker.service
    systemctl status docker.service
    #运行docker镜像
    #破解rico授权版本
    docker run -d --name=镜像 -e speedtest=0  -e api_port=2333 -e usemysql=0 -e downWithPanel=0 -e node_id=节点ID -e sspanel_url=域名 -e key=密码 -e CacheDurationSec=120 --log-opt max-size=10m --log-opt max-file=5 --network=host --restart=always xiaoyang12/woaixy:latest
    docker run -d --name=镜像 -e speedtest=0 -e usemysql=0 -e downWithPanel=0 -e node_id=节点ID -e sspanel_url=域名 -e key=密码 --log-opt max-size=10m --log-opt max-file=5 --network=host --restart=always xiaoyang12/woaixy:latest
    #无名版本
    docker run -d --name=镜像 -e speedtest=0  -e api_port=2333 -e usemysql=0 -e downWithPanel=0 -e node_id=节点ID -e sspanel_url=域名 -e key=密码 -e CacheDurationSec=120 --log-opt max-size=10m --log-opt max-file=5 --network=host --restart=always yduj9e/hef:4.25.0-beta2
    #狐狸sang版本
    docker run -d --name=镜像 -e speedtest=0  -e api_port=2333 -e usemysql=0 -e downWithPanel=0 -e node_id=节点ID -e sspanel_url=域名 -e key=密码 -e CacheDurationSec=120 --log-opt max-size=10m --log-opt max-file=5 --network=host --restart=always hulisang/v2ray_v3:go_dev  


###自己测试：

    tls CF 模式 ：域名或者ip;;1;tls;ws;path=/v2ray|host=域名或者ip    #脚本对接
    tls caddy模式 ：域名或者ip;;1;tls;ws;path=/v2ray|host=域名或者ip  #脚本对接
    ws模式：  地址;端口;2;ws;;path=/img|host=域名    #docker破解rico第二个
------------------------------------------------
>*TCP 示例，请注意后面有两个分号*
>>非CDN域名或者ip;非0;2;tcp;;

>*WS*
>>非CDN域名或者ip;8080;2;ws;;path=/v2ray|host=这里可以用加了CDN的域名

>*WS + TLS (自动配置）*
>>非CDN域名或者ip;非0;2;tls;ws;path=/v2ray|host=tls的域名|inside_port=10550

>*WS + TLS (Caddy 提供)*
>>非CDN域名或者ip;0;2;tls;ws;path=/v2ray|host=tls的域名|inside_port=10550|outside_port=443


>*nat鸡 ws*
>>非CDN域名或者ip;非0;2;ws;;path=/v2ray|host=这里可以用加了CDN的域名

>*nat鸡 ws + tls (自动配置)，因为部分商家并不提供 80 & 443 访问，所以请考虑手动申请 SSL 证书*
>>非CDN域名或者ip;非0;2;tls;ws;path=/v2ray|host=tls的域名

>*nat鸡 ws + tls (Caddy 提供)，因为部分商家并不提供 80 & 443 访问，所以请考虑手动申请 SSL 证书*
>>非CDN域名或者ip;0;2;tls;ws;path=/v2ray|host=tls的域名|inside_port=10550|outside_port=11120

---------------------------------------------

>_以下为 KCP 示例部分，支持所有 V2Ray 的 type：_

> *// none: 默认值，不进行伪装，发送的数据是没有特征的数据包。*
>>非CDN域名或者ip;非0;2;kcp;noop;

>*// srtp: 伪装成 SRTP 数据包，会被识别为视频通话数据（如 FaceTime）。*
>>非CDN域名或者ip;非0;2;kcp;srtp;

>*// utp: 伪装成 uTP 数据包，会被识别为 BT 下载数据。*
>>非CDN域名或者ip;非0;2;kcp;utp;

>*// wechat-video: 伪装成微信视频通话的数据包。*
>>非CDN域名或者ip;非0;2;kcp;wechat-video;

>*// dtls: 伪装成 DTLS 1.2 数据包。*
>>非CDN域名或者ip;非0;2;kcp;dtls;

>*// wireguard: 伪装成 WireGuard 数据包(并不是真正的 WireGuard 协议) 。*
>>非CDN域名或者ip;非0;2;kcp;wireguard;

***********************************
    --panelurl https://google.com  表示 WEBAPI URL
    --panelkey 55fUxDGFzH3n  表示 MU KEY
    --nodeid 123456  节点 ID，可以为 0
    --downwithpanel 1  前端面板异常下线时，0 为节点端不下线、1 为节点跟着下线
    --mysqlhost https://bing.com  数据库访问域名
    --mysqldbname demo_dbname  数据库名
    --mysqluser demo_user  数据库用户名
    --mysqlpasswd demo_dbpassword  数据库密码
    --mysqlport 3306  数据库连接端口
    --speedtestrate 6  测速周期
    --paneltype 0  面板类型，0 为 ss-panel-v3-mod、1 为 SSRPANEL
    --usemysql 0  连接方式，0 为 webapi，1 为 MySQL 数据库连接，请注意 SSRPANEL 必须使用数据库连接
    --lsdn xx.xx.xx.xx  xx.xx.xx.xx 是你要设定的dns地址
    --cfkey xxxx cloudflare key
    --cfemail  xxxx cloudflare email
    --local xxx.zip   rico记忆中 免费版的安装脚本用这个参数可以安装本地压缩包