#Start Zookeeper, kafka cluster and create the requried topics for kafka-connect-splunk
sleep 60
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 10 --topic offset.storage.topic
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 10 --topic config.storage.topic
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 10 --topic status.storage.topic
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 10 --topic perf
sleep 20
java -jar ./kafka-data-gen.jar -message-count 1000000 -message-size 256 -message-delay 0 -output-file "./logfile.txt" -topic perf -bootstrap.servers "kafka:9092" -acks all -kafka-retries 0 -kafka-batch-size 16384 -kafka-linger 1 -kafka-buffer-memory 33554432
tail -f /dev/null