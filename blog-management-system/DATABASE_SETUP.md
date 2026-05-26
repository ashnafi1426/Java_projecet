# Database Setup Guide

## Database Configuration

This project is configured to connect to a MySQL database with the following credentials:

- **Database Name:** ashube
- **Username:** ashube
- **Password:** 05747674
- **Host:** localhost
- **Port:** 3306

## Prerequisites

1. MySQL Server 8.0 or higher installed and running
2. MySQL command-line client (usually comes with MySQL Server)

## Setup Instructions

### Option 1: Using the Setup Script (Recommended)

1. Open Command Prompt or PowerShell
2. Navigate to the project directory:
   ```bash
   cd Java_projecet/blog-management-system
   ```
3. Run the setup script:
   ```bash
   setup-database.bat
   ```
4. Enter your MySQL root password when prompted
5. The script will create the database and user automatically

### Option 2: Manual Setup

1. Open MySQL command line or MySQL Workbench
2. Login as root:
   ```bash
   mysql -u root -p
   ```
3. Run the following SQL commands:
   ```sql
   -- Create database
   CREATE DATABASE IF NOT EXISTS ashube 
   CHARACTER SET utf8mb4 
   COLLATE utf8mb4_unicode_ci;
   
   -- Create user
   CREATE USER IF NOT EXISTS 'ashube'@'localhost' IDENTIFIED BY '05747674';
   CREATE USER IF NOT EXISTS 'ashube'@'%' IDENTIFIED BY '05747674';
   
   -- Grant privileges
   GRANT ALL PRIVILEGES ON ashube.* TO 'ashube'@'localhost';
   GRANT ALL PRIVILEGES ON ashube.* TO 'ashube'@'%';
   FLUSH PRIVILEGES;
   ```

### Option 3: Using SQL File

Run the provided SQL script:
```bash
mysql -u root -p < CREATE_DATABASE.sql
```

## Testing the Connection

After setup, test the connection:

```bash
test-db-connection.bat
```

Or manually:
```bash
mysql -h localhost -P 3306 -u ashube -p05747674 -e "SHOW DATABASES LIKE 'ashube';"
```

## Troubleshooting

### MySQL is not running
- **Windows:** Open Services and start "MySQL80" service
- **Command:** `net start MySQL80`

### Cannot connect to MySQL
1. Check if MySQL is listening on port 3306:
   ```bash
   netstat -an | findstr 3306
   ```
2. Verify MySQL is running:
   ```bash
   mysql --version
   ```

### Access denied for user 'ashube'
1. Make sure you ran the CREATE_DATABASE.sql script
2. Verify the user was created:
   ```sql
   SELECT User, Host FROM mysql.user WHERE User='ashube';
   ```
3. Check user privileges:
   ```sql
   SHOW GRANTS FOR 'ashube'@'localhost';
   ```

### Database does not exist
Run the setup script or CREATE_DATABASE.sql again.

## Running the Application

Once the database is set up and tested:

1. **Using Maven:**
   ```bash
   mvnw.cmd spring-boot:run
   ```

2. **Using Java directly:**
   ```bash
   mvnw.cmd clean package
   java -jar target/blog-management-system-1.0.0.jar
   ```

The application will:
- Connect to the database automatically
- Run Flyway migrations (if enabled)
- Create all necessary tables
- Start on http://localhost:8080

## Accessing the Application

- **API Documentation:** http://localhost:8080/swagger-ui.html
- **API Docs JSON:** http://localhost:8080/api-docs
- **Health Check:** http://localhost:8080/actuator/health

## Configuration Files

The database configuration is stored in:
- `src/main/resources/application.properties` - Main configuration
- `.env.example` - Environment variables template
- `docker-compose.yml` - Docker configuration

## Security Note

⚠️ **Important:** The database credentials in this configuration are for development purposes only. 

For production:
1. Use environment variables
2. Use strong, unique passwords
3. Restrict database user privileges
4. Enable SSL connections
5. Use a secrets management system

## Next Steps

After successful database setup:
1. ✅ Database is ready
2. Run the Spring Boot application
3. The application will create all tables automatically
4. Access the Swagger UI to test the API endpoints
5. Start developing!
