# FROM debezium/connect:2.6

# # Create directory for custom connectors
# RUN mkdir -p /usr/share/local-connectors

# # Copy ClickHouse connector
# COPY ./connect-plugins/clickhouse /usr/share/local-connectors/clickhouse

# # Update plugin path to include custom connectors directory
# ENV CONNECT_PLUGIN_PATH="/kafka/connect,/usr/share/confluent-hub-components,/usr/share/local-connectors"


FROM debezium/connect:2.6

RUN mkdir -p /kafka/connect/local-connectors/ && chmod -R 755 /kafka/connect/local-connectors/

RUN curl -L https://repo1.maven.org/maven2/io/debezium/debezium-connector-mysql/2.6.0.Final/debezium-connector-mysql-2.6.0.Final-plugin.tar.gz \
  | tar -xz -C /kafka/connect/local-connectors/

RUN mkdir -p /kafka/connect/local-connectors/clickhouse
COPY ./connect-plugins/clickhouse /kafka/connect/local-connectors/clickhouse
