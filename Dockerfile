# Stage 1: Build with Maven
FROM maven:3.8.6-amazoncorretto-11 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package

# Stage 2: Deploy to Tomcat
FROM tomcat:9.0.65-jre11
COPY --from=builder target/WebAppCal-1.3.5.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]