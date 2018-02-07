FROM anapsix/alpine-java:8_jdk

ENV SCALA_VERSION 2.12
ENV KAFKA_VERSION 0.11.0.1
ENV KAFKA_HOME /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"

RUN apk update && apk upgrade && apk add git && apk add openssh && apk add openssl && apk add python && apk add gcc && apk add python-dev && apk add musl-dev && apk add linux-headers && apk add curl

RUN wget -q https://bootstrap.pypa.io/get-pip.py -P / && python get-pip.py && pip install requests && pip install psutil

RUN wget -q http://apache.claz.org/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz -P /bin && cd /bin && tar xzf apache-maven-3.5.2-bin.tar.gz

ENV PATH=${PATH}:/bin/apache-maven-3.5.2/bin

RUN wget -q https://archive.apache.org/dist/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -P /tmp/
RUN tar xfz /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -C /opt
RUN rm /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz



WORKDIR /kafka-connect-splunk
COPY connect-distributed.properties .
COPY splunk-kafka-connect_100.jar /tmp


COPY script.sh /kafka-connect-splunk
RUN chmod +x script.sh

EXPOSE 8083

CMD ["/bin/sh", "-c", "/kafka-connect-splunk/script.sh"]
	