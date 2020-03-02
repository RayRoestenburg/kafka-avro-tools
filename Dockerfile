FROM adoptopenjdk/openjdk8:ubuntu
RUN  apt-get update \
  && apt-get install -y wget tar jq bash kafkacat \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /avro-tools \
  && wget https://repo1.maven.org/maven2/org/apache/avro/avro-tools/1.8.2/avro-tools-1.8.2.jar -P /avro-tools \
  && wget -qO- http://apache.cs.uu.nl/kafka/2.4.0/kafka_2.12-2.4.0.tgz | tar -xvz
ENV PATH="/kafka_2.12-2.4.0/bin:/avro-tools:${PATH}"
COPY schemas /schemas
  
CMD tail -f /dev/null