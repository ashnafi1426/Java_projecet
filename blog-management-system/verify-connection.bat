@echo off
echo ========================================
echo Database Connection Verification
echo ========================================
echo.
echo Testing connection to database 'ashube'...
echo.

C:\xampp\mysql\bin\mysql.exe -h localhost -P 3306 -u ashube -p05747674 ashube -e "SELECT 'Connection successful!' as Status; SELECT VERSION() as MySQL_Version; SELECT DATABASE() as Current_Database; SHOW TABLES;"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo ✅ CONNECTION SUCCESSFUL!
    echo ========================================
    echo.
    echo Database: ashube
    echo User: ashube
    echo Host: localhost:3306
    echo.
    echo Your Spring Boot application can now connect!
    echo.
    echo To start the application, run:
    echo   mvnw.cmd spring-boot:run
    echo.
) else (
    echo.
    echo ❌ Connection failed
    echo.
)
