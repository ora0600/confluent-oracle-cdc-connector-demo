#!/bin/bash

# create connector
curl -i -X POST -H “Accept:application/json” \
  -H  “Content-Type:application/json” http://localhost:8083/connectors/ \
  -d ‘{
    “name”: “cdc-oracle-source-pdb”,
    “config”: {
        “connector.class”: “io.confluent.connect.oracle.cdc.OracleCdcSourceConnector”,
        “tasks.max”:1,
        “key.converter”: “io.confluent.connect.avro.AvroConverter”,
        “key.converter.schema.registry.url”: “http://schema-registry:8081”,
        “value.converter”: “io.confluent.connect.avro.AvroConverter”,
        “value.converter.schema.registry.url”: “http://schema-registry:8081”,
        “confluent.license”: “”,
        “confluent.topic.bootstrap.servers”: “broker:29092",
        “confluent.topic.replication.factor”: “1",
        “oracle.server”: “oracledb”,
        “oracle.port”: 1521,
        “oracle.sid”: “ORCLCDB”,
        “oracle.pdb.name”: “ORCLPDB1”,
        “oracle.username”: “C##MYUSER”,
        “oracle.password”: “mypassword”,
        “start.from”:“snapshot”,
        “redo.log.topic.name”: “redo-log-topic”,
        “redo.log.consumer.bootstrap.servers”:“broker:29092”,
        “table.inclusion.regex”: “ORCLPDB1[.].*[.]CUSTOMERS”,
        “table.topic.name.template”: “${databaseName}.${schemaName}.${tableName}“,
        “connection.pool.max.size”: 20,
        “confluent.topic.replication.factor”: 1,
        “redo.log.row.fetch.size”: 1
      }
  }’