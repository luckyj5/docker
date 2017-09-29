#!/bin/sh
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/zookeeper-server-start.sh -daemon /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/config/zookeeper.properties
sleep 5
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/kafka-server-start.sh -daemon /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/config/server.properties
sleep 15
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 10 --topic offset.storage.topic
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 10 --topic config.storage.topic
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 10 --topic status.storage.topic
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 10 --topic perf

sleep 5

java -jar ./kafka-data-gen.jar -message-count 1000000 -message-size 256 -message-delay 0 -output-file "./logfile.txt" -topic perf -bootstrap.servers "localhost:9092" -acks all -kafka-retries 0 -kafka-batch-size 16384 -kafka-linger 1 -kafka-buffer-memory 33554432


/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/connect-distributed.sh /kafka-connect-splunk/connect-distributed.properties
echo "starting kafka-connect"

curl localhost:8083/connectors -X POST -H "Content-Type: application/json" -d '{"name": "kafka-connect-splunk","config":{"topics": "perf","tasks.max": "3","connector.class": "com.splunk.kafka.connect.SplunkSinkConnector","splunk.hec.uri": "https://127.0.0.1:8088","splunk.hec.token": "842637D8-C86E-4915-8976-D6857B5407C1","splunk.hec.raw": "false","splunk.hec.ack.enabled": "true","splunk.hec.ssl.validate.certs": "false","name": "kafka-connect-splunk"}}}'

tail -f /dev/null