#!/bin/sh
#Start kafka-connect
sleep 60
export KAFKA_HEAP_OPTS=$KAFKA_HEAP_OPTS
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/connect-distributed.sh -daemon /kafka-connect-splunk/connect-distributed.properties

#Start kafka-connect-splunk Sink connector
sleep 60
curl kafka-connect:8083/connectors -X POST -H "Content-Type: application/json" -d '{
	"name": "'"$CONNECTOR_NAME"'",
	"config":{
		"topics": "'"$KAFKA_TOPIC"'",
		"tasks.max": "'"$MAX_TASKS"'",
		"connector.class": "com.splunk.kafka.connect.SplunkSinkConnector",
		"splunk.hec.uri": "'"$SPLUNK_HEC_ENDPOINT"'",
		"splunk.hec.token": "'"$SPLUNK_HEC_TOKEN"'",
		"splunk.hec.raw": "'"$SPLUNK_HEC_RAW"'",
		"splunk.hec.ack.enabled": "'"$SPLUNK_HEC_ACK_ENABLED"'",
		"splunk.hec.ssl.validate.certs": "false",
		"splunk.indexes": "'"$SPLUNK_INDEX"'",
		"splunk.sources": "'"$SPLUNK_SOURCE"'",
		"splunk.sourcetypes": "'"$SPLUNK_SOURCETYPE"'",
		"name": "kafka-connect-splunk"
	}
}'

tail -f /dev/null
