# kafka-avro-tools

Very simple docker image with kafka utilities, for instance for reading AVRO messages from a Kafka topic and printing them in JSON format.

> NOTE: you need to add your own schema files to the schemas directory before building the image.

## Build

```
docker build -t kafka-avro-tools .
docker tag kafka-avro-tools:latest docker.io/rayroestenburg/kafka-avro-tools:latest
docker push docker.io/rayroestenburg/kafka-avro-tools:latest
```

## Use on a Kubernetes cluster
Find your Kafka broker in the cluster (`kubectl get svc`, find cluster IP for bootstrap servers), replace `<namespace>`, `<broker-cluster-IP>`, `<topic>` and `<schema-file>` below:

```
kubectl -n <namespace> apply -f pod.yaml
kubectl exec -n <namespace> -it kafka-avro-tools -- /bin/bash

kafkacat -C -b <broker-cluster-IP>:9092 -t <topic> -q -u -D "" -f %s | java -jar /avro-tools/avro-tools-1.8.2.jar fragtojson --schema-file /schemas/<schema-file> - | jq .
```
