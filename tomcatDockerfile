#tomcat
FROM ubuntu:20.04

RUN apt-get update && apt-get -y install openjdk-17-jre-headless wget

RUN apt-get update && apt-get install -y mariadb-server

RUN service mysql start

RUN mkdir /home/tomcat
WORKDIR /home/tomcat

RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.76/bin/apache-tomcat-9.0.76.tar.gz
RUN tar xvfz apache-tomcat-9.0.76.tar.gz
RUN rm apache-tomcat-9.0.76.tar.gz

RUN chmod -R 777 /etc/profile
RUN echo 'export CATALINA_HOME=/home/tomcat/apache-tomcat-9.0.76' >> /etc/profile

ENV CATALINA_HOME /home/tomcat/apache-tomcat-9.0.76

RUN cd /home/tomcat/apache-tomcat-9.0.76/lib && wget https://downloads.mariadb.com/Connectors/java/connector-java-2.7.4/mariadb-java-client-2.7.4.jar

COPY index.jsp /home/tomcat/apache-tomcat-9.0.76/webapps/ROOT/
COPY context.xml /home/tomcat/apache-tomcat-9.0.76/conf/


RUN /home/tomcat/apache-tomcat-9.0.76/bin/shutdown.sh && /home/tomcat/apache-tomcat-9.0.76/bin/startup.sh

EXPOSE 8080

CMD ["/home/tomcat/apache-tomcat-9.0.76/bin/catalina.sh", "run"]
