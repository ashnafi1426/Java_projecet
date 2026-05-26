@echo off
echo ========================================
echo Blog Management System - Full Stack
echo ========================================
echo.
echo This will start both:
echo   1. Backend API (Spring Boot) on port 8080
echo   2. Frontend Desktop App (JavaFX)
echo.
echo ⚠️  Note: First startup may take 5-10 minutes
echo    (downloading Maven dependencies)
echo.
pause

echo.
echo Starting Backend API in new window...
start "Backend API - Port 8080" cmd /k start-backend.bat

echo.
echo Waiting 30 seconds for backend to initialize...
timeout /t 30 /nobreak

echo.
echo Starting Frontend Desktop Application in new window...
start "Desktop Frontend - JavaFX" cmd /k start-frontend.bat

echo.
echo ========================================
echo Both applications are starting!
echo ========================================
echo.
echo Backend API: http://localhost:8080
echo Swagger UI: http://localhost:8080/swagger-ui.html
echo.
echo The desktop application window will open shortly.
echo.
echo To stop: Close both terminal windows
echo.
pause
