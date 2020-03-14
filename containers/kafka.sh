#!/bin/bash

function dc_cass() {
    docker-compose -f docker-compose-cassandra.yml up -d
}

function dc_stop() {
    docker-compose stop
}

function dc_up() {
    docker-compose up -d
}

function dc_down() {
    docker-compose down
}

function janus_gremlin() {
    docker exec -ti graph1 ./bin/gremlin.sh
}

########################################
## Kafka
########################################

function kf_producer() {
    echo "starting producer ..."
    docker exec -ti kafka /opt/kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic kafka.test
}

function kf_consumer() {
    echo "starting consumer ..."
    docker exec -ti kafka /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic kafka.test --from-beginning
}

function kf_list_brokers() {
    echo "listing brokers ..."
    docker exec -ti kafka /usr/bin/broker-list.sh
}

function kf_create_topic() {
    echo "creating topic: $1"
    docker exec -ti kafka /opt/kafka/bin/kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 1 --topic $1
    echo "topic created"
}

function kf_list_topics() {
    echo "listing topics ..."
    docker exec -ti kafka /opt/kafka/bin/kafka-topics.sh --list --zookeeper zookeeper:2181
}
