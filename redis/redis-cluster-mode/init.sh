#!/bin/bash
echo "初始化node: $1"
mkdir /redis
cp /vagrant/redis-5.0.5.tar.gz /redis
cd /redis
tar -zxvf redis-5.0.5.tar.gz
cd /redis/redis-5.0.5/
make install

mkdir /usr/local/redis -p
mkdir /usr/local/redis/working -p

cp /vagrant/redis.conf /usr/local/redis
cp /vagrant/redis_init_script /etc/init.d/
chmod 777 /etc/init.d/redis_init_script
/etc/init.d/redis_init_script start
chkconfig redis_init_script on

echo "Redis OK"


if [[ $1 -eq 6 ]]; then
# 自动输入yes
yes | /redis/redis-5.0.5/src/redis-cli -a 123456 --cluster create 192.168.33.21:6379 192.168.33.22:6379 192.168.33.23:6379 192.168.33.24:6379 192.168.33.25:6379 192.168.33.26:6379 --cluster-replicas 1
echo "Redis Cluster OK"
fi
