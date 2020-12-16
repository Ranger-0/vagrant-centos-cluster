#!/bin/bash
timedatectl set-timezone Asia/Shanghai

mkdir /redis
cd /redis
wget http://download.redis.io/releases/redis-5.0.5.tar.gz
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