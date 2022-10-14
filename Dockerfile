# syntax=docker/dockerfile:1

FROM eclipse-temurin:17-jdk-jammy as base
ADD . /root/app
WORKDIR /root/app
RUN ./mvnw dependency:resolve

FROM base as development
ENTRYPOINT ./start.sh

FROM base as build
RUN ./mvnw package

FROM eclipse-temurin:17-jre-jammy as production
EXPOSE 8080
COPY --from=build /app/target/spring-petclinic-*.jar /spring-petclinic.jar
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/spring-petclinic.jar"]