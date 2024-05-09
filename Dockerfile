FROM maven:3.8.7-openjdk-18 as builder

ENV HOME=/opt/paygo

RUN mkdir $HOME

WORKDIR $HOME

COPY pom.xml .
COPY local-repo ./local-repo

RUN mvn dependency:go-offline

ADD . .

COPY ./src/main/resources/application.sample.properties \
     ./src/main/resources/application.properties

RUN mvn package

EXPOSE 9000