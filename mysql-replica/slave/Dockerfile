FROM mysql:5.7
ADD ./slave/my.cnf /etc/mysql/my.cnf

RUN [ "/script/startReplicaSlave.sh" ] 

ENTRYPOINT [ "mysqld" ]
