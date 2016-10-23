FROM openjdk:alpine
VOLUME /tmp
ADD target/spring-data-vaadin-crud-0.0.1-SNAPSHOT.jar app.jar
RUN sh -c 'touch /app.jar'
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar","--spring.profiles.active=postgres"]