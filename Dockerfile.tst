FROM openjdk:8-jdk-alpine as stage1
ADD . /root/app
WORKDIR /root/app
EXPOSE 8080:8080
RUN apk update && apk add dos2unix
RUN chmod +x start.sh

FROM stage1 as stage2
RUN dos2unix start.sh
RUN chmod +x start.sh
ENTRYPOINT ./start.sh
