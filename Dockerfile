# ==========================================
# STAGE 1: Build the React Frontend
# ==========================================
FROM node:20-alpine AS frontend-builder
WORKDIR /frontend

# Copy frontend dependency manifests and install them
COPY frontend/package*.json ./
RUN npm ci

# Copy frontend source code and compile to static files
COPY frontend/ ./
RUN npm run build

# ==========================================
# STAGE 2: Build the Java Backend
# ==========================================
FROM maven:3.9-eclipse-temurin-17 AS backend-builder
WORKDIR /backend

# Copy the backend build configuration files
COPY backend/pom.xml ./

# Create the folder where Java looks for static web assets
RUN mkdir -p src/main/resources/static

# Copy the compiled React assets from Stage 1 into Java's static folder
COPY --from=frontend-builder /frontend/dist src/main/resources/static

# Copy the rest of your Java source code
COPY backend/src ./src

# Compile and package into a production-ready .jar file
RUN mvn clean package -DskipTests

# ==========================================
# STAGE 3: Minimal Production Runtime
# ==========================================
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Copy only the compiled .jar file from Stage 2
COPY --from=backend-builder /backend/target/*.jar app.jar

# Open the port your Java application listens on (usually 8080)
EXPOSE 8080

# Launch the full-stack application
ENTRYPOINT ["java", "-jar", "app.jar"]