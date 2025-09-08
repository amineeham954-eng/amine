# Étape 1 : Builder avec Maven
FROM maven:3.9.2-jdk-21 AS build
WORKDIR /app

# Copier le fichier pom.xml et le dossier src
COPY pom.xml .
COPY src ./src

# Builder le projet sans exécuter les tests
RUN mvn package -DskipTests

# Étape 2 : Exécuter l'application
FROM eclipse-temurin:21-jdk
WORKDIR /app

# Copier le jar depuis l'étape build
COPY --from=build /app/target/projetjava-1.0-SNAPSHOT.jar app.jar

# Commande pour lancer l'application
CMD ["java", "-jar", "app.jar"]


