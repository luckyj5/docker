#Start Zookeeper, kafka cluster and create the requried topics for kafka-connect-splunk
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
tail -f /dev/null