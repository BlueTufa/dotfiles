FROM bitnami/spark:latest

USER root
RUN mkdir -p /var/lib/apt/lists/partial
RUN apt update && apt install -y wget
RUN wget -P /opt/bitnami/spark/jars https://repo1.maven.org/maven2/io/delta/delta-core_2.12/2.4.0/delta-core_2.12-2.4.0.jar

USER 1001
ENTRYPOINT [ "/opt/bitnami/scripts/spark/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/spark/run.sh" ]
