# syntax=docker/dockerfile:1

FROM eclipse-temurin:17-jdk-jammy as base
ADD . /root/app
WORKDIR /root/app
VOLUME /tmp
COPY .mvn/ .mvn
COPY mvnw pom.xml start.sh ./
#RUN ./mvnw dependency:resolve
COPY src ./src
RUN chmod +x start.sh
RUN apt-get update && apt-get install dos2unix && apt-get install maven -y
RUN dos2unix start.sh 
RUN dos2unix mvnw
#RUN chmod +x mvnw & ./mvnw clean package 


FROM base as development
RUN chmod +x start.sh
ENTRYPOINT ./start.sh

FROM base as build
RUN ./mvnw package

FROM eclipse-temurin:17-jre-jammy as production
EXPOSE 8080
COPY --from=build /app/target/spring-petclinic-*.jar /spring-petclinic.jar
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/spring-petclinic.jar"]