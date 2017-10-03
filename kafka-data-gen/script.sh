#Start Zookeeper, kafka cluster and create the requried topics for kafka-connect-splunk
sleep 60
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 10 --topic offset.storage.topic
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 10 --topic config.storage.topic
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 10 --topic status.storage.topic
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 10 --topic perf
sleep 20
java -jar ./kafka-data-gen.jar -message-count $KAFKA_MSG_COUNT -message-size $KAFKA_MSG_SIZE -message-delay 0 -output-file "./logfile.txt" -topic $KAFKA_TOPIC -bootstrap.servers "kafka:9092" -acks all -kafka-retries 0 -kafka-batch-size $KAFKA_BATCH_SIZE -kafka-linger 1 -kafka-buffer-memory $KAFKA_BUFFER_MEMORY
tail -f /dev/null