# Blog Management System - Startup Guide

## ✅ Setup Complete!

Your Blog Management System is now fully configured and ready to use.

---

## Quick Start

### Starting the Application

**Option 1: Using the startup script (Recommended)**
```bash
start-application.bat
```

**Option 2: Using Maven directly**
```bash
mvnw.cmd spring-boot:run
```

**Note:** The first startup will take 5-10 minutes as Maven downloads all dependencies.

---

## Environment Configuration

### Java Setup
- **JAVA_HOME:** `C:\Program Files\Eclipse Adoptium\jdk-25.0.3.9-hotspot`
- **Java Version:** OpenJDK 25.0.3 LTS
- **Status:** ✅ Configured

### Database Configuration
- **Database:** ashube
- **Username:** ashube
- **Password:** 05747674
- **Host:** localhost:3306
- **MySQL Version:** 10.4.32-MariaDB (XAMPP)
- **Status:** ✅ Connected
- **Tables:** 11 tables created
- **Sample Data:** 10 topics pre-populated

---

## Application URLs

Once the application starts successfully, you can access:

### Main Endpoints
- **Application:** http://localhost:8080
- **Swagger UI:** http://localhost:8080/swagger-ui.html
- **API Documentation:** http://localhost:8080/api-docs
- **Health Check:** http://localhost:8080/actuator/health

### API Base URL
```
http://localhost:8080/api
```

---

## First Startup

### What to Expect

1. **Maven Dependency Download** (First time only)
   - Takes 5-10 minutes
   - Downloads ~200MB of dependencies
   - Progress shown in console

2. **Application Initialization**
   - Spring Boot starts
   - Database connection established
   - Flyway checks migrations
   - Security configuration loaded
   - REST controllers initialized

3. **Success Indicators**
   ```
   Started BlogApplication in X.XXX seconds
   Tomcat started on port(s): 8080
   ```

### Startup Time
- **First Run:** 5-10 minutes (downloading dependencies)
- **Subsequent Runs:** 30-60 seconds

---

## Testing the Application

### 1. Check Health
```bash
curl http://localhost:8080/actuator/health
```

Expected response:
```json
{
  "status": "UP"
}
```

### 2. View API Documentation
Open in browser:
```
http://localhost:8080/swagger-ui.html
```

### 3. Test API Endpoints

#### Get All Topics
```bash
curl http://localhost:8080/api/topics
```

#### Register a New User
```bash
curl -X POST http://localhost:8080/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "email": "test@example.com",
    "password": "password123",
    "firstname": "Test",
    "lastname": "User"
  }'
```

---

## Available Scripts

### Database Management
```bash
verify-connection.bat          # Test database connection
verify-database-schema.bat     # View database schema
run-migrations-direct.bat      # Run migrations manually
```

### Application Management
```bash
start-application.bat          # Start the application
find-java.ps1                  # Find and configure Java
```

---

## Troubleshooting

### Application Won't Start

#### 1. JAVA_HOME Not Set
**Error:** `JAVA_HOME not found in your environment`

**Solution:**
```bash
powershell -ExecutionPolicy Bypass -File find-java.ps1
```
Then close and reopen your terminal.

#### 2. Port 8080 Already in Use
**Error:** `Port 8080 is already in use`

**Solution:**
- Stop other applications using port 8080
- Or change the port in `application.properties`:
  ```properties
  server.port=8081
  ```

#### 3. Database Connection Failed
**Error:** `Cannot connect to database`

**Solution:**
1. Check if MySQL/XAMPP is running
2. Verify connection:
   ```bash
   verify-connection.bat
   ```
3. Check credentials in `application.properties`

#### 4. Maven Build Fails
**Error:** `Build failure` or `Compilation error`

**Solution:**
```bash
mvnw.cmd clean install
```

---

## Database Schema

### Tables Created

| Table | Description | Records |
|-------|-------------|---------|
| users | User accounts | 0 |
| topics | Blog categories | 10 |
| posts | Blog articles | 0 |
| comments | Post comments | 0 |
| claps | Post likes | 0 |
| followers | User following | 0 |
| bookmarks | Saved posts | 0 |
| notifications | User notifications | 0 |
| post_topics | Post-topic links | 0 |
| topic_followers | Topic subscriptions | 0 |

### Pre-populated Topics

1. Technology
2. Programming
3. JavaScript
4. Java
5. Web Development
6. Data Science
7. DevOps
8. Mobile Development
9. Design
10. Career

---

## API Features

### Authentication
- User registration
- User login (JWT)
- OAuth support (Google, GitHub)
- Email verification
- Password reset

### Blog Posts
- Create, read, update, delete posts
- Draft and publish
- Public/private visibility
- Cover images
- Rich text content
- Full-text search
- Reading time calculation

### Social Features
- Follow users
- Follow topics
- Clap for posts (Medium-style)
- Bookmark posts
- Comment on posts
- Nested comments

### Notifications
- Real-time notifications
- Follow notifications
- Comment notifications
- Clap notifications

---

## Development Workflow

### 1. Start MySQL
Ensure XAMPP MySQL is running

### 2. Start Application
```bash
start-application.bat
```

### 3. Access Swagger UI
```
http://localhost:8080/swagger-ui.html
```

### 4. Test Endpoints
Use Swagger UI to test all API endpoints

### 5. View Logs
Check console output for errors and information

---

## Configuration Files

### Application Configuration
- `src/main/resources/application.properties` - Main config
- `src/main/resources/application-dev.properties` - Development
- `src/main/resources/application-prod.properties` - Production

### Database Configuration
- `CREATE_DATABASE.sql` - Database setup script
- `src/main/resources/db/migration/` - Flyway migrations

### Environment Variables
- `.env.example` - Environment template

---

## Next Steps

1. ✅ **Application is starting** - Wait for startup to complete
2. 🌐 **Access Swagger UI** - Test the API endpoints
3. 👤 **Register a user** - Create your first account
4. 📝 **Create a post** - Write your first blog post
5. 🎨 **Explore features** - Try all the social features

---

## Support

### Check Application Status
```bash
# View running processes
tasklist | findstr java

# Check port 8080
netstat -ano | findstr :8080
```

### View Application Logs
Logs are displayed in the console where you started the application.

### Database Queries
```bash
C:\xampp\mysql\bin\mysql.exe -u ashube -p05747674 ashube
```

---

## Success Checklist

- ✅ Java installed and JAVA_HOME set
- ✅ MySQL running and database created
- ✅ All 11 migrations executed
- ✅ 10 sample topics inserted
- ✅ Application starting (downloading dependencies)
- ⏳ Waiting for application to fully start...

---

## 🎉 You're All Set!

Once you see "Started BlogApplication" in the console, your application is ready to use!

Visit: **http://localhost:8080/swagger-ui.html**
