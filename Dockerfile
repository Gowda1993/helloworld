ARG TEST=/var/lib/
WORKDIR ${TEST}
COPY . .
RUN /usr/bin/mvn clean package
RUN which mvn
FROM tomcat:jre8-temurin-focal
ARG TEST=/var/lib
COPY --from=mavenbuilder ${TEST}/target/hello-world-war-1.0.0.war /usr/local/tomcat/webapps
