FROM luckyj5/kafka_zk:0.0.1

COPY script.sh /
ADD kafka-data-gen.jar /
RUN chmod +x script.sh
EXPOSE 8083 9092

CMD ["/bin/sh", "-c", "/script.sh"]