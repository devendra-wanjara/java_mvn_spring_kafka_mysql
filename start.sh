#!/bin/sh
echo "Starting"
./mvnw spring-boot:run -Dspring-boot.run.profiles=mysql -Drun.jvmArguments="-Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8000"