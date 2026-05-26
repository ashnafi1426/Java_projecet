@echo off
setlocal enabledelayedexpansion

echo ========================================
echo Database Migration Script
echo ========================================
echo.
echo Database: ashube
echo User: ashube
echo Host: localhost:3306
echo.
echo This will run all migration files in order:
echo.

set MYSQL_PATH=C:\xampp\mysql\bin\mysql.exe
set DB_HOST=localhost
set DB_PORT=3306
set DB_USER=ashube
set DB_PASS=05747674
set DB_NAME=ashube

REM Check if MySQL exists
if not exist "%MYSQL_PATH%" (
    echo Error: MySQL not found at %MYSQL_PATH%
    echo Please update the MYSQL_PATH variable in this script
    pause
    exit /b 1
)

echo Found MySQL at: %MYSQL_PATH%
echo.

REM Create Flyway schema history table
echo Creating Flyway schema history table...
%MYSQL_PATH% -h %DB_HOST% -P %DB_PORT% -u %DB_USER% -p%DB_PASS% %DB_NAME% -e "CREATE TABLE IF NOT EXISTS flyway_schema_history (installed_rank INT NOT NULL, version VARCHAR(50), description VARCHAR(200) NOT NULL, type VARCHAR(20) NOT NULL, script VARCHAR(1000) NOT NULL, checksum INT, installed_by VARCHAR(100) NOT NULL, installed_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, execution_time INT NOT NULL, success BOOLEAN NOT NULL, PRIMARY KEY (installed_rank), INDEX flyway_schema_history_s_idx (success)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;" 2>nul

if %ERRORLEVEL% EQU 0 (
    echo ✅ Flyway table ready
) else (
    echo ❌ Failed to create Flyway table
    pause
    exit /b 1
)

echo.
echo Running migrations...
echo.

set SUCCESS_COUNT=0
set FAIL_COUNT=0

REM Run each migration file
for %%f in (src\main\resources\db\migration\V*.sql) do (
    echo Executing: %%~nxf...
    %MYSQL_PATH% -h %DB_HOST% -P %DB_PORT% -u %DB_USER% -p%DB_PASS% %DB_NAME% < "%%f" 2>nul
    
    if !ERRORLEVEL! EQU 0 (
        echo   ✅ Success
        set /a SUCCESS_COUNT+=1
    ) else (
        echo   ❌ Failed
        set /a FAIL_COUNT+=1
    )
)

echo.
echo ========================================
echo Migration Summary
echo ========================================
echo Successful: %SUCCESS_COUNT%
echo Failed: %FAIL_COUNT%
echo.

if %FAIL_COUNT% EQU 0 (
    echo ✅ All migrations completed successfully!
    echo.
    echo Checking created tables...
    echo.
    %MYSQL_PATH% -h %DB_HOST% -P %DB_PORT% -u %DB_USER% -p%DB_PASS% %DB_NAME% -e "SHOW TABLES;"
    echo.
    echo Your database is ready!
) else (
    echo ⚠️  Some migrations failed
)

echo.
pause
