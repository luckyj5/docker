#!/bin/sh
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/zookeeper-server-start.sh /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/config/zookeeper.properties
