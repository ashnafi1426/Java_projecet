@echo off
echo ========================================
echo Starting Backend API Server
echo ========================================
echo.

REM Set JAVA_HOME to Java 17
set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.19.10-hotspot
set PATH=%JAVA_HOME%\bin;%PATH%

echo JAVA_HOME: %JAVA_HOME%
echo.

REM Verify Java version
echo Verifying Java version...
java -version
echo.

echo Starting Spring Boot Backend...
echo.
echo Backend will be available at:
echo   - API: http://localhost:8080/api
echo   - Swagger UI: http://localhost:8080/swagger-ui.html
echo   - Health: http://localhost:8080/actuator/health
echo.
echo Database: ashube @ localhost:3306
echo.
echo Press Ctrl+C to stop the backend
echo.

REM Start the backend API
mvnw.cmd spring-boot:run -Dspring-boot.run.mainClass=com.blogapp.BlogApplication

pause
