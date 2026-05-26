-- Create Database Script
-- Run this file first before starting the application

CREATE DATABASE IF NOT EXISTS ashube 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- Create user if not exists
CREATE USER IF NOT EXISTS 'ashube'@'localhost' IDENTIFIED BY '05747674';
CREATE USER IF NOT EXISTS 'ashube'@'%' IDENTIFIED BY '05747674';

-- Grant privileges
GRANT ALL PRIVILEGES ON ashube.* TO 'ashube'@'localhost';
GRANT ALL PRIVILEGES ON ashube.* TO 'ashube'@'%';
FLUSH PRIVILEGES;

-- Verify database creation
SHOW DATABASES LIKE 'ashube';

-- Use the database
USE ashube;

-- Show current database
SELECT DATABASE();
