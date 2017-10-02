#!/bin/sh
sleep 30
/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin/kafka-server-start.sh /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/config/server.properties