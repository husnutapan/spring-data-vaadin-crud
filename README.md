# Spring Data JPA CRUD with Vaadin

A super simple single table CRUD example with [Spring Data JPA](http://projects.spring.io/spring-data-jpa/) and [Vaadin](https://vaadin.com). Uses [Spring Boot](http://projects.spring.io/spring-boot/) for easy project setup and development. Helps you to get started with basic JPA backed applications and [Vaadin Spring Boot](https://vaadin.com/addon/vaadin-spring-boot) integration library.

For larger applications, consider applying some commonly known design patterns for your UI code. Check e.g. [this MVP example](https://github.com/peholmst/vaadin4spring/tree/master/spring-vaadin-mvp).

As an example for a really easy Vaadin add-on usage, there is Switch add-on added as a dependency and the application uses [wscdn.vaadin.com](https://wscdn.vaadin.com) service to compile and host the widgetset. To make it work in your project, see [this part in pom.xml](https://github.com/mstahv/spring-data-vaadin-crud/blob/master/pom.xml#L100-L112) and [this row](https://github.com/mstahv/spring-data-vaadin-crud/blob/master/src/main/java/crud/Application.java#L11) in your configuration.

#Dockerize application containers with docker-compose

```
git clone https://github.com/ahmetoz/spring-data-vaadin-crud.git
cd spring-data-vaadin-crud
mvn package
docker-compose up
```

#Details..

##Dockerfile

```
FROM openjdk:alpine
VOLUME /tmp
ADD target/spring-data-vaadin-crud-0.0.1-SNAPSHOT.jar app.jar
RUN sh -c 'touch /app.jar'
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar","--spring.profiles.active=postgres"]
```

##docker-compose.yml
```
 version: '2'

  services:
    web:
      build: .
      ports:
        - "8091:8080"
      networks:
        - my_network
      environment:
        POSTGRES: postgres
        POSTGRES_USERNAME: postgres
        POSTGRES_PASSWORD: mysecretword

    postgres:
      image: postgres
      networks:
        - my_network
      environment:
        POSTGRES_PASSWORD: mysecretword

  networks:
    my_network:
```

##application-postgres.properties

```
spring.jpa.database=POSTGRESQL
spring.jpa.hibernate.ddl-auto=update
spring.datasource.url=jdbc:postgresql://postgres:5432/postgres?user=${POSTGRES_USERNAME}&password=${POSTGRES_PASSWORD}
spring.datasource.driverClassName=org.postgresql.Driver
```

with networking docker will not longer set the  **POSTGRES_PORT_5432_TCP_ADDR** variables, etc.
db name: postgres 

