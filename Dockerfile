FROM ubuntu:jammy

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install curl git wget zip openjdk-8-jdk mysql-client -y
COPY ./scripts/unzip.sh /root/

COPY ./files/apache-tomcat-8.5.100.zip /root/tomcat/
RUN /root/unzip.sh

COPY ./files/openmrs.war /opt/tomcat8/webapps/

RUN mkdir /root/.OpenMRS
COPY ./files/openmrs-runtime.properties /root/.OpenMRS/
COPY ./files/openmrs-runtime.properties /opt/tomcat8/bin/
COPY ./files/modules/ /root/.OpenMRS/modules/
COPY ./scripts/tomcatStart.sh /root/tomcatStart.sh

RUN chmod -R 777 /root/.OpenMRS
RUN chmod -R 777 /opt/tomcat8
RUN chmod +x /root/tomcatStart.sh

EXPOSE 8080