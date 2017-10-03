FROM luckyj5/kafka_zk:0.0.1

WORKDIR /kafka-connect-splunk
ADD . /kafka-connect-splunk
COPY cloudfwd-1.0-SNAPSHOT.jar /kafka-connect-splunk-1/libs/com/splunk/cloudfwd/1.0-SNAPSHOT/
COPY kafka-connect-splunk-1.0-SNAPSHOT.jar /tmp

COPY script.sh /kafka-connect-splunk
RUN chmod +x script.sh

EXPOSE 8083

CMD ["/bin/sh", "-c", "/kafka-connect-splunk/script.sh"]




