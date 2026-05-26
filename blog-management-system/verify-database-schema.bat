@echo off
echo ========================================
echo Database Schema Verification
echo ========================================
echo.

set MYSQL_PATH=C:\xampp\mysql\bin\mysql.exe
set DB_HOST=localhost
set DB_PORT=3306
set DB_USER=ashube
set DB_PASS=05747674
set DB_NAME=ashube

echo Database: %DB_NAME%
echo User: %DB_USER%
echo Host: %DB_HOST%:%DB_PORT%
echo.

echo ========================================
echo All Tables
echo ========================================
%MYSQL_PATH% -h %DB_HOST% -P %DB_PORT% -u %DB_USER% -p%DB_PASS% %DB_NAME% -e "SHOW TABLES;"

echo.
echo ========================================
echo Table Row Counts
echo ========================================
%MYSQL_PATH% -h %DB_HOST% -P %DB_PORT% -u %DB_USER% -p%DB_PASS% %DB_NAME% -e "SELECT 'users' as TableName, COUNT(*) as RowCount FROM users UNION ALL SELECT 'topics', COUNT(*) FROM topics UNION ALL SELECT 'posts', COUNT(*) FROM posts UNION ALL SELECT 'comments', COUNT(*) FROM comments UNION ALL SELECT 'claps', COUNT(*) FROM claps UNION ALL SELECT 'followers', COUNT(*) FROM followers UNION ALL SELECT 'bookmarks', COUNT(*) FROM bookmarks UNION ALL SELECT 'notifications', COUNT(*) FROM notifications;"

echo.
echo ========================================
echo Sample Topics
echo ========================================
%MYSQL_PATH% -h %DB_HOST% -P %DB_PORT% -u %DB_USER% -p%DB_PASS% %DB_NAME% -e "SELECT name, slug, description FROM topics;"

echo.
echo ========================================
echo Users Table Structure
echo ========================================
%MYSQL_PATH% -h %DB_HOST% -P %DB_PORT% -u %DB_USER% -p%DB_PASS% %DB_NAME% -e "DESCRIBE users;"

echo.
echo ========================================
echo Posts Table Structure
echo ========================================
%MYSQL_PATH% -h %DB_HOST% -P %DB_PORT% -u %DB_USER% -p%DB_PASS% %DB_NAME% -e "DESCRIBE posts;"

echo.
echo ========================================
echo Database Size
echo ========================================
%MYSQL_PATH% -h %DB_HOST% -P %DB_PORT% -u %DB_USER% -p%DB_PASS% %DB_NAME% -e "SELECT table_name AS 'Table', ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)' FROM information_schema.TABLES WHERE table_schema = '%DB_NAME%' ORDER BY (data_length + index_length) DESC;"

echo.
echo ✅ Database schema verification complete!
echo.
pause
