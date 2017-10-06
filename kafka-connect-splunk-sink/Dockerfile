FROM java:openjdk-8-jre

ARG DEBIAN_FRONTEND=noninteractive
ENV SCALA_VERSION 2.12
ENV KAFKA_VERSION 0.11.0.1
ENV KAFKA_HOME /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"

# Install Kafka, Zookeeper and other needed things
RUN apt-get update && apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/* && \
    wget -q http://apache.mirrors.spacedump.net/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -O /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz && \
    tar xfz /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -C /opt && \
    rm /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz

WORKDIR /kafka-connect-splunk
COPY connect-distributed.properties .
COPY kafka-connect-splunk-1.0-SNAPSHOT.jar /tmp

COPY script.sh /kafka-connect-splunk
RUN chmod +x script.sh

EXPOSE 8083

CMD ["/bin/sh", "-c", "/kafka-connect-splunk/script.sh"]
	