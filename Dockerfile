FROM openjdk:11
ARG DEMO_FILE=target/*.jar
COPY ${DEMO_FILE} bank.jar
ENTRYPOINT ["java","-jar","/bank.jar"]
