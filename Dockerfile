FROM openliberty/daily:full

COPY src/main/liberty/config/server.xml /config/server.xml
COPY target/liberty/wlp/usr/servers/defaultServer/bootstrap.properties /config/bootstrap.properties
#COPY src/main/liberty/config/server.env /config/server.env
#COPY src/main/liberty/config/jvm.options /config/jvm.options
COPY target/system-service-1.0-SNAPSHOT.war /config/apps/

USER 0

RUN chown 1001:0 /config/server.xml
RUN chown 1001:0 /config/server.env
#RUN chown 1001:0 /config/jvm.options
RUN chown 1001:0 /config/apps/system-service-1.0-SNAPSHOT.war

USER 1001

RUN configure.sh || if [ $? -ne 22 ]; then exit $?; fi
