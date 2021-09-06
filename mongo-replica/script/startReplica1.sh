sleep 10
echo "Waiting for MongoDB startup.."
until [ "$(mongo --host mongo1:27017 admin --eval "printjson(db.serverStatus())" | grep uptime | head -1)" ]; do
  printf '.'
done

echo $(mongo --host mongo1:27017 admin --eval "printjson(db.serverStatus())" | grep uptime | head -1)
echo "MongoDB Started.."


echo SETUP.sh time now: `date +"%T" `
mongo --host mongo1:27017 <<EOF
   var cfg = {
        "_id": "rs0",
        "members": [
            {
                "_id": 0,
                "host": "mongo1:27017",
                "priority": 2
            },
            {
                "_id": 1,
                "host": "mongo2:27017",
                "priority": 0
            },
            {
                "_id": 2,
                "host": "mongo3:27017",
                "priority": 1,
                "arbiterOnly": true
            }
        ]
    };
    rs.initiate(cfg, { force: true });
    rs.reconfig(cfg, { force: true });
EOF