#!/bin/sh
# health check
until mysql -h 127.0.0.1 -P 3306 -uroot -ppassword --protocol=tcp -e "select 1 from dual" | grep -q 1;
do
    >&2 echo "Replication master is unavailable - sleeping"
    sleep 1
done
>&2 echo "Replication master is up - setting slave"

mysql -h 127.0.0.1 -P 3306 -uroot -ppassword --protocol=tcp -e "CHANGE MASTER TO MASTER_HOST='10.5.0.5', MASTER_USER='root', MASTER_PASSWORD='password', MASTER_LOG_FILE='mysql-bin.000013', MASTER_LOG_POS=0;"
mysql -h 127.0.0.1 -P 3306 -uroot -ppassword --protocol=tcp -e "start slave;"
mysql -h 127.0.0.1 -P 3306 -uroot -ppassword --protocol=tcp -e "show slave status;"