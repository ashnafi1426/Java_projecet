@echo off
echo ========================================
echo Starting Desktop Frontend (JavaFX)
echo ========================================
echo.

REM Set JAVA_HOME to Java 17
set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.19.10-hotspot
set PATH=%JAVA_HOME%\bin;%PATH%

echo JAVA_HOME: %JAVA_HOME%
echo.

echo ⚠️  IMPORTANT: Make sure the backend is running first!
echo    Run start-backend.bat in another terminal
echo.
echo Starting JavaFX Desktop Application...
echo.

REM Start the JavaFX desktop application
mvnw.cmd javafx:run

pause
