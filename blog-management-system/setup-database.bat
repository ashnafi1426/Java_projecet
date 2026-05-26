@echo off
echo ========================================
echo Database Setup Script
echo ========================================
echo.
echo This script will:
echo 1. Create the 'ashube' database
echo 2. Create the 'ashube' user
echo 3. Grant necessary privileges
echo.
echo You will need your MySQL root password.
echo.
pause

echo.
echo Running CREATE_DATABASE.sql...
echo.

mysql -u root -p < CREATE_DATABASE.sql

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo ✅ DATABASE SETUP SUCCESSFUL!
    echo ========================================
    echo.
    echo Database 'ashube' has been created
    echo User 'ashube' has been created with password: 05747674
    echo.
    echo Now testing the connection...
    echo.
    
    mysql -h localhost -P 3306 -u ashube -p05747674 -e "SELECT 'Connection successful!' as Status; USE ashube; SHOW TABLES;"
    
    if %ERRORLEVEL% EQU 0 (
        echo.
        echo ✅ Connection test passed!
        echo Your Spring Boot application is ready to run.
    ) else (
        echo.
        echo ⚠️  Database created but connection test failed.
        echo Please check the credentials.
    )
) else (
    echo.
    echo ========================================
    echo ❌ DATABASE SETUP FAILED
    echo ========================================
    echo.
    echo Please check:
    echo 1. MySQL is running
    echo 2. You entered the correct root password
    echo 3. MySQL is accessible on localhost:3306
)

echo.
pause
