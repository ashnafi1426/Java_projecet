@echo off
echo ========================================
echo Database Migration Script
echo ========================================
echo.
echo This will run all Flyway migrations on the 'ashube' database
echo.
echo Database: ashube
echo User: ashube
echo Host: localhost:3306
echo.
echo Migration files to be executed:
echo   V1__Create_Users_Table.sql
echo   V2__Create_Topics_Table.sql
echo   V3__Create_Posts_Table.sql
echo   V4__Create_Post_Topics_Table.sql
echo   V5__Create_Comments_Table.sql
echo   V6__Create_Claps_Table.sql
echo   V7__Create_Followers_Table.sql
echo   V8__Create_Topic_Followers_Table.sql
echo   V9__Create_Bookmarks_Table.sql
echo   V10__Create_Notifications_Table.sql
echo   V11__Insert_Sample_Topics.sql
echo.
pause

echo.
echo Starting Spring Boot application to run migrations...
echo.

mvnw.cmd spring-boot:run -Dspring-boot.run.arguments="--spring.flyway.enabled=true"

echo.
echo Migration complete!
echo.
pause
