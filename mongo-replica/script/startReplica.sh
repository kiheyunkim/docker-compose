#!/usr/bin/env bash

nohup /root/script/startReplica1.sh &

sleep 10
/usr/bin/mongod --bind_ip_all --replSet rs0