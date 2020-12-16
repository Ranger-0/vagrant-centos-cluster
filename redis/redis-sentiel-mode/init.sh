#!/bin/bash
echo "初始化node: $1"

timedatectl set-timezone Asia/Shanghai
mkdir /redis
cp /vagrant/redis-5.0.5.tar.gz /redis
cd /redis
tar -zxvf redis-5.0.5.tar.gz
cd /redis/redis-5.0.5/
make install

mkdir /usr/local/redis -p
mkdir /usr/local/redis/working -p

if [[ $1 -eq 1 ]]; then
cp /vagrant/redis-master/redis.conf /usr/local/redis
fi

if [[ $1 -ne 1 ]]; then
cp /vagrant/redis-slave/redis.conf /usr/local/redis
fi

cp /vagrant/redis_init_script /etc/init.d/
chmod 777 /etc/init.d/redis_init_script
/etc/init.d/redis_init_script start
chkconfig redis_init_script on

echo "Redis OK"

mkdir /usr/local/redis/sentinel -p
cp /vagrant/sentinel.conf /usr/local/redis

# make install生成的命令无法立刻使用
/redis/redis-5.0.5/src/redis-sentinel /usr/local/redis/sentinel.conf
echo "Sentiel OK"