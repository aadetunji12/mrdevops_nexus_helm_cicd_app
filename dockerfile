# Stage 1: Build the application with Maven
FROM maven:3.8.4 as build
WORKDIR /app
COPY . .
RUN mvn clean package

# Stage 2: Run the application with OpenJDK 11
FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/target/devops-integration.jar /app/
EXPOSE 8080
CMD ["java", "-jar", "devops-integration.jar"]
