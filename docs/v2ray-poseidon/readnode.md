## 1.前端面板填写方式

>TCP模式：

    你的IP或域名;10086;2;tcp;;
>CloudFlare CDN + WebSocket 模式1（推荐）:

    你的域名;443;0;tls;ws;path=/|host=你的域名
>WebSocket-TLS 模式 2:

    你的域名;443;0;tls;ws;path=/|host=你的域名

## 2.樱花云专用一键脚本
    wget --no-check-certificate -O xiaoyangzengqiang.sh https://raw.githubusercontent.com/xiaoyanggo/v2rayshell/master/xiaoyangzengqiang.sh && chmod +x xiaoyangzengqiang.sh && ./xiaoyangzengqiang.sh