from alpine:3.7

#设置默认时区为亚洲/上海 (没有北京可选)
RUN apk add --no-cache --upgrade apk-tools tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone && apk del tzdata

EXPOSE 8000

#这里增加python3
RUN apk add --no-cache --upgrade git python3 python3-dev gcc musl-dev libxslt-dev linux-headers && pip3 install --upgrade pip requests chardet sqlalchemy utils psutil lxml web.py==0.40-dev1 gevent

#克隆代理池源码
RUN git clone https://github.com/javmain/IPProxyPool.git

#启动代理池
CMD python3 /IPProxyPool/IPProxy.py


#echo 停止容器
#docker stop Iproxypool
#echo 删除容器
#docker rm Iproxypool
#echo 临时禁用selinux
#setenforce 0
#echo 重建镜像
#docker build -t ipproxypool .
#echo 恢复启用selinux
#setenforce 1
#echo 启动容器
#docker run -d -t --restart=always --privileged --name Iproxypool -p 8000:8000 ipproxypool