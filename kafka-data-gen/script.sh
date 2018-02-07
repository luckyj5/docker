#Start Zookeeper, kafka cluster and create the requried topics for kafka-connect-splunk
sleep 60
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 10 --topic offset.storage.topic
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 10 --topic config.storage.topic
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 10 --topic status.storage.topic
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 10 --topic $KAFKA_TOPIC
sleep 20

java -jar ./kafka-data-gen.jar -message-count $KAFKA_MSG_COUNT -message-size $KAFKA_MSG_SIZE -topic $KAFKA_TOPIC -bootstrap.servers "kafka:9092" -acks all -kafka-retries 0 -kafka-batch-size $KAFKA_BATCH_SIZE -kafka-linger 1 -kafka-buffer-memory $KAFKA_BUFFER_MEMORY -eps $KAFKA_EPS


tail -f /dev/null