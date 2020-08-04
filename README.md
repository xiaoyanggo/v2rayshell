# v2rayshell

###v2ray p版本脚本：

    wget --no-check-certificate -O xiaoyangzengqiang.sh https://raw.githubusercontent.com/xiaoyanggo/v2rayshell/master/xiaoyangzengqiang.sh && chmod +x xiaoyangzengqiang.sh && ./xiaoyangzengqiang.sh

###v2ray rico版本

    mkdir v2ray-agent  &&   cd v2ray-agent && curl https://raw.githubusercontent.com/xiaoyanggo/v2rayshell/master/v2xy.sh -o v2xy.sh &&  chmod +x v2xy.sh &&  bash v2xy.sh

####自己测试：

    tls CF 模式 ： ces.yhy.design;;16;tls;ws;path=/v2ray|host=ces.yhy.design 

    tls caddy模式 ：ces.yhy.design;;16;tls;ws;path=/v2ray|host=ces.yhy.design  
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