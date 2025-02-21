

## Use an official Maven image to build the application
FROM registry.twilio.com/library/java/build-maven-jdk-17-corretto as builder

WORKDIR /app
COPY . /app
#RUN #mvn dependency:go-offline
RUN mvn clean package -DskipTests
#
FROM registry.twilio.com/library/java/jdk-17-corretto-debian-slim

#RUN #useradd twilio
COPY --from=builder --chown=twilio:twilio app/target/anurag-test-0.0.1-SNAPSHOT.jar  /app/bin/anurag-test-0.0.1-SNAPSHOT.jar

WORKDIR /app

#COPY --from=builder app/target/anurag-test-0.0.1-SNAPSHOT.jar ./anurag-test-0.0.1-SNAPSHOT.jar




COPY --chown=twilio:twilio docker-entrypoint.sh /app/bin/
RUN chmod +x /app/bin/docker-entrypoint.sh
USER twilio
ENTRYPOINT ["/app/bin/docker-entrypoint.sh"]

# Run the Java application
#CMD ["java", "-jar", "anurag-test-0.0.1-SNAPSHOT.jar"]


#FROM registry.twilio.com/library/java/jre-17-zulu-amazonlinux-2023:main-latest

# Curl is useful for testing connectivity while inside a Pod
#USER root
#RUN apt-get update && \
#    apt-get install -y curl && \
#    apt-get install -y dnsutils
#
## Use non-root user to run the application
#USER nobody

#EXPOSE 8080
#FROM openjdk:17

#FROM registry.twilio.com/library/java/jdk-17-corretto-debian-slim
#COPY target/anurag-test-0.0.1-SNAPSHOT.jar /service/bin/app.jar
#
#WORKDIR /service
##EXPOSE 9397 9498
#
#ENTRYPOINT ["java", "-jar", "/service/bin/app.jar"]
#WORKDIR /app
#
##USER twilio
#
#COPY . /app
#
##RUN #mvn dependency:go-offline
##RUN mvn clean package -DskipTests
#USER nobody
#
#COPY target/anurag-test-0.0.1-SNAPSHOT.jar ./anurag-test-0.0.1-SNAPSHOT.jar
#
#CMD ["java", "-jar", "anurag-test-0.0.1-SNAPSHOT.jar"]
##CMD ["sh", "-c", "while true; do echo 'Debugging...'; sleep 60; done"]

#FROM registry.twilio.com/library/java/jdk-17-corretto-debian-slim

#USER root
#RUN apt-get update && \
#    apt-get install -y curl && \
#    apt-get install -y dnsutils

# Use non-root user to run the application
#USER nobody

#EXPOSE 8081
#WORKDIR /service
#ENTRYPOINT ["/service/bin/docker-entrypoint.sh"]
#
#COPY docker-entrypoint.sh /service/bin/
#COPY target/anurag-test-0.0.1-SNAPSHOT.jar /service/bin/