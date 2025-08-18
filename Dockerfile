#BUILD STAGE
FROM maven:3.9.8-eclipse-temurin-17 AS build
WORKDIR workspace/
COPY app/pom.xml ./app/pom.xml
RUN --mount=type=cache,target=/root/.m2 mvn -f app/pom.xml -q -B dependency:go-offline
COPY app ./app
RUN --mount=type=cache,target=/root/.m2 mvn -f app/pom.xml -q -B clean package -DskipTests

#RUNTIME STAGE
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /workspace/app/target/demo-1.0.0.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
