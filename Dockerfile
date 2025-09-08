# Étape 1 : Builder avec Maven
FROM maven:3.9.2-jdk-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn package -DskipTests

# Étape 2 : Exécuter l'application
FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY --from=build /app/target/mon-projet-java-1.0-SNAPSHOT.jar app.jar
CMD ["java", "-jar", "app.jar"]


