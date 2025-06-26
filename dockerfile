# Etapa 1: compilar el jar
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

# Copiar todo el proyecto
COPY . .

# Compilar la aplicación
RUN mvn clean package -DskipTests
RUN ls -l /app/target/

# Etapa 2: empaquetar la app
FROM eclipse-temurin:21-jdk-alpine
RUN mkdir -p /app
WORKDIR /app

# Copiar el JAR generado
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8761
ENTRYPOINT ["java", "-jar", "app.jar"]
