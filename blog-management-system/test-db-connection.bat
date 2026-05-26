@echo off
echo ========================================
echo Database Connection Test
echo ========================================
echo.
echo Testing connection to MySQL database...
echo Database: ashube
echo Username: ashube
echo Password: 05747674
echo Host: localhost:3306
echo.
echo Attempting to connect...
echo.

mysql -h localhost -P 3306 -u ashube -p05747674 -e "SELECT 'Connection successful!' as Status; SELECT VERSION() as MySQL_Version; SHOW DATABASES LIKE 'ashube';" 2>nul

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo ✅ CONNECTION SUCCESSFUL!
    echo ========================================
    echo.
    echo Checking tables in ashube database...
    mysql -h localhost -P 3306 -u ashube -p05747674 ashube -e "SHOW TABLES;" 2>nul
    echo.
    echo Your database is ready for the Spring Boot application!
) else (
    echo.
    echo ========================================
    echo ❌ CONNECTION FAILED
    echo ========================================
    echo.
    echo Troubleshooting:
    echo 1. Make sure MySQL is running
    echo 2. Verify the database 'ashube' exists
    echo 3. Check if user 'ashube' has been created
    echo 4. Verify the password is correct: 05747674
    echo.
    echo To create the database and user, run:
    echo    mysql -u root -p ^< CREATE_DATABASE.sql
)

echo.
pause
