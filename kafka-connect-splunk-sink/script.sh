#!/bin/sh
#Start kafka-connect
sleep 30
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/connect-distributed.sh -daemon /kafka-connect-splunk/connect-distributed.properties

#Start kafka-connect-splunk Sink connector
sleep 30
curl kafka-connect:8083/connectors -X POST -H "Content-Type: application/json" -d '{"name": "kafka-connect-splunk","config":{"topics": "'"$KAFKA_TOPIC"'","tasks.max": "3","connector.class": "com.splunk.kafka.connect.SplunkSinkConnector","splunk.hec.uri": "'"$SPLUNK_HEC_ENDPOINT"'","splunk.hec.token": "'"$SPLUNK_HEC_TOKEN"'","splunk.hec.raw": "false","splunk.hec.ack.enabled": "true","splunk.hec.ssl.validate.certs": "false","name": "kafka-connect-splunk"}}}'

tail -f /dev/null