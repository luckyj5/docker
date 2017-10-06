# Docker
Make life easier with Docker! 

This repo contains the following: 

## Zookeeper
Start zookeeper services in a container.
Create required topics for kafka connect splunk 

## Kafka
Start kafka services in a conatainer 


## Kafka-data-gen
Creates required kafka topics in kafka conatiner and generates data/ messages using kafka data-gen-app jar and stream them to a specified kafka-topic (eg: perf) 

## Kafka-connect-splunk-sink
Contains Kafka Connect Splunk Sink connector to send data to Splunk from specified Kafka topic (eg: perf)

## Deployment: 
Adjust docker-compose.yml for your deployment (Specify Splunk_Hec_Endpoint and Splunk_Hec_Token)

Run `docker-compose up` to start all the containers

Login to Splunk server and you should see data from Kafka topic (perf) into Splunk. 

