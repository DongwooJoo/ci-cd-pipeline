# build stage
FROM gradle:8.5-jdk21 AS builder
WORKDIR /workspace
COPY --chown=gradle:gradle . /workspace
RUN gradle clean bootJar -x test

# runtime stage
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app
COPY --from=builder /workspace/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]