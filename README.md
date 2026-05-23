# 📝 Blog Management System

> **A Modern, Full-Featured Enterprise Blog Platform Built with Java Spring Boot**  
> Seamlessly connect writers, readers, and communities in a beautiful blogging experience.

---

## ✨ Overview

**Blog Management System** is a powerful, production-ready blogging platform that brings the best of modern web technologies to the Java ecosystem. Originally architected with MERN stack principles and now reimagined with Spring Boot, this system delivers a robust foundation for building scalable blogging applications.

Whether you're creating a personal blog, building a content platform for your organization, or learning enterprise Java development, this project provides everything you need—from user authentication to real-time engagement features.

### Why This Project? 

- 🎯 **Production-Ready**: Built with enterprise best practices and scalability in mind
- 🔒 **Security First**: JWT authentication, role-based access control, and encrypted secrets
- 📱 **Developer Friendly**: Well-organized code, clear separation of concerns, comprehensive documentation
- 🐳 **Container Ready**: Docker support for instant deployment
- 📚 **Learning Resource**: Excellent for understanding Spring Boot best practices

---

## 🎯 Key Features

### 👥 User Management
- User registration and authentication with JWT tokens
- Profile management with customizable settings
- Role-based access control (Admin, Author, Reader)
- Secure password hashing and reset functionality

### ✍️ Content Creation & Publishing
- Create, edit, and publish blog posts with rich formatting
- Organize posts by topics and tags
- Draft and schedule post functionality
- Markdown support for technical writers

### 💬 Community Engagement
- Comment system with nested reply support
- Clap/Like system for post appreciation
- Follow authors and topics to get personalized feed
- Real-time notifications for interactions

### 🔖 Content Discovery
- Bookmark favorite posts for later reading
- Advanced search and filtering options
- Topic-based categorization and discovery
- Trending posts and popular authors

### 📊 Additional Capabilities
- Responsive design that works on all devices
- SEO-friendly URL structure
- API documentation with Swagger/OpenAPI
- Database migration management with Flyway
- Comprehensive error handling and logging

---

## 🚀 Technology Stack

### Backend Excellence
| Technology | Version | Purpose |
|-----------|---------|---------|
| **Java** | 17+ | Core language with modern features |
| **Spring Boot** | 3.2.5 | Application framework |
| **Spring Security** | Latest | Authentication & authorization |
| **Spring Data JPA** | Latest | Database abstraction layer |
| **Hibernate** | Latest | ORM framework |
| **PostgreSQL** | 12+ | Relational database |

### Frontend & UI
- **Thymeleaf** - Server-side template engine for dynamic content
- **Bootstrap 5** - Responsive UI components and styling
- **JavaScript** - Client-side interactivity and validation

### Developer Tools & Libraries
| Tool | Purpose |
|------|---------|
| **Flyway** | Database schema versioning & migration |
| **Lombok** | Reduce boilerplate with annotations |
| **MapStruct** | Type-safe bean mapping |
| **Swagger/OpenAPI** | Interactive API documentation |
| **Docker** | Containerization for consistent deployment |
| **Maven** | Build automation and dependency management |

---

## 📁 Project Architecture

```
blog-management-system/
├── src/
│   ├── main/
│   │   ├── java/com/blogapp/
│   │   │   ├── BlogApplication.java      # Application entry point
│   │   │   ├── config/                   # Configuration & setup
│   │   │   │   └── OpenApiConfig.java
│   │   │   ├── controller/               # REST API endpoints
│   │   │   │   ├── AuthController.java
│   │   │   │   ├── PostController.java
│   │   │   │   ├── UserController.java
│   │   │   │   └── ...
│   │   │   ├── service/                  # Business logic layer
│   │   │   ├── repository/               # Data access layer
│   │   │   ├── entity/                   # JPA entities (DB models)
│   │   │   ├── dto/                      # Data transfer objects
│   │   │   ├── security/                 # JWT & security config
│   │   │   ├── exception/                # Custom exception handling
│   │   │   └── desktop/                  # JavaFX desktop application
│   │   └── resources/
│   │       ├── application.properties    # Configuration files
│   │       ├── db/migration/             # SQL migration scripts
│   │       ├── static/                   # CSS, JS, images
│   │       └── templates/                # Thymeleaf HTML templates
│   └── test/                             # Unit & integration tests
├── pom.xml                               # Maven dependencies
├── Dockerfile                            # Docker container config
├── docker-compose.yml                    # Multi-container setup
└── README.md                             # This file
```

**Design Pattern**: Follows **Layered Architecture** with clear separation of concerns (Controller → Service → Repository → Entity)

---

## 🔧 Prerequisites

Before you begin, ensure you have the following installed on your system:

| Requirement | Version | Download |
|-------------|---------|----------|
| **Java Development Kit** | 17 or higher | [adoptopenjdk.net](https://adoptopenjdk.net/) |
| **Maven** | 3.6 or higher | [maven.apache.org](https://maven.apache.org/) |
| **PostgreSQL** | 12 or higher | [postgresql.org](https://www.postgresql.org/) |
| **Git** | Latest | [git-scm.com](https://git-scm.com/) |

*Optional: Docker & Docker Compose for containerized setup*

---

## ⚡ Quick Start Guide

### 🐳 Option 1: Docker (Recommended - Fastest)

Get up and running in seconds with Docker:

```bash
# Clone the repository
git clone <repository-url>
cd blog-management-system

# Start everything with Docker Compose
docker-compose up -d

# Wait for containers to initialize (about 10-15 seconds)
# Application is now live at http://localhost:8080
```

**What happens**: Docker automatically sets up PostgreSQL, initializes the database, and starts your application.

---

### 💻 Option 2: Local Development Setup

Perfect for development and learning:

#### Step 1: Clone & Navigate
```bash
git clone <repository-url>
cd blog-management-system
```

#### Step 2: Set Up PostgreSQL Database
```bash
# Using command line
createdb blogdb

# Or using pgAdmin/GUI tools
# Create a new database named "blogdb"
```

#### Step 3: Configure Application
Edit `src/main/resources/application.properties`:

```properties
# Database Configuration
spring.datasource.url=jdbc:postgresql://localhost:5432/blogdb
spring.datasource.username=postgres
spring.datasource.password=your_password

# JWT Security Configuration
jwt.secret=your-super-secret-256-bit-key-here-change-this-in-production
jwt.expiration=86400000  # 24 hours in milliseconds

# Server Configuration
server.port=8080

# Logging
logging.level.root=INFO
logging.level.com.blogapp=DEBUG
```

#### Step 4: Build the Project
```bash
mvn clean install -DskipTests
```

This downloads all dependencies and compiles the code. Grab a ☕ coffee while Maven works its magic!

#### Step 5: Run the Application
```bash
mvn spring-boot:run
```

🎉 **Success!** Your application is running at `http://localhost:8080`

---

### 🧪 Running Tests

Ensure everything works correctly:

```bash
# Run all tests
mvn test

# Run specific test class
mvn test -Dtest=UserServiceTest

# Run with code coverage
mvn test jacoco:report
```

---

## 📡 API Documentation

Once the application is running, explore the interactive API documentation:

- **Swagger UI**: [http://localhost:8080/swagger-ui.html](http://localhost:8080/swagger-ui.html)
- **OpenAPI JSON**: [http://localhost:8080/v3/api-docs](http://localhost:8080/v3/api-docs)

Here you can test all API endpoints directly from your browser!

---

## 🔐 Security Configuration

### JWT Authentication
The application uses JWT (JSON Web Tokens) for stateless authentication:

1. User logs in with credentials
2. Server validates and issues a JWT token
3. Client includes token in `Authorization: Bearer <token>` header
4. Server validates token on each request

### Environment Variables (Production)
Never commit secrets! Create a `.env` file:

```bash
DATABASE_URL=jdbc:postgresql://db-host:5432/blogdb
DB_USERNAME=your_username
DB_PASSWORD=your_secure_password
JWT_SECRET=your-very-secure-256-bit-secret-key
PROFILE=prod
```

Then reference in `application.properties`:
```properties
spring.datasource.url=${DATABASE_URL}
spring.datasource.username=${DB_USERNAME}
spring.datasource.password=${DB_PASSWORD}
jwt.secret=${JWT_SECRET}
```

---

## 📊 Database Schema

The database is automatically created and migrated using Flyway. Check the migration files to understand the schema:

```
db/migration/
├── V1__Create_Users_Table.sql
├── V2__Create_Topics_Table.sql
├── V3__Create_Posts_Table.sql
├── V4__Create_Post_Topics_Table.sql
├── V5__Create_Comments_Table.sql
├── V6__Create_Claps_Table.sql
├── V7__Create_Followers_Table.sql
├── V8__Create_Topic_Followers_Table.sql
├── V9__Create_Bookmarks_Table.sql
└── V10__Create_Notifications_Table.sql
```

Each file represents a version of your database, making it easy to track changes and roll back if needed.

---

## 🐛 Troubleshooting

### "Connection refused to PostgreSQL"
```bash
# Ensure PostgreSQL is running
psql -U postgres  # Should connect without errors

# Check if database exists
psql -U postgres -l | grep blogdb

# If missing, create it:
createdb blogdb
```

### "Maven build fails with dependency errors"
```bash
# Clear Maven cache and retry
mvn clean install -DskipTests

# If still failing, check your internet connection and Maven settings
```

### "Port 8080 already in use"
```bash
# Option 1: Change port in application.properties
server.port=8081

# Option 2: Find and stop the process using port 8080
# On Windows:
netstat -ano | findstr :8080
taskkill /PID <PID> /F
```

### "JWT token validation fails"
- Ensure `jwt.secret` in `application.properties` matches across all instances
- Check token hasn't expired (default: 24 hours)
- Verify token format in Authorization header: `Bearer <token>`

### Application starts but shows errors
```bash
# Check logs for more details
tail -f logs/application.log

# Or run with debug logging
mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Ddebug"
```

---

## 📖 Project Structure Deep Dive

### Layer 1: Controllers (`controller/`)
REST API endpoints handling HTTP requests. Each endpoint maps to a service method.

**Example**: `PostController` handles `/api/posts` endpoints

### Layer 2: Services (`service/`)
Business logic and validation. Controllers call services to process data.

**Example**: `PostService` handles post creation, validation, and notifications

### Layer 3: Repositories (`repository/`)
Database access abstraction using Spring Data JPA. Repositories query and persist data.

**Example**: `PostRepository` provides `findById()`, `save()`, and custom queries

### Layer 4: Entities (`entity/`)
Database table representations as Java classes. One class = one table.

**Example**: `Post` entity maps to `posts` table in PostgreSQL

---

## 🚀 Deployment Guide

### Deploy to Docker Hub
```bash
# Build image
docker build -t yourusername/blog-app:latest .

# Push to Docker Hub
docker push yourusername/blog-app:latest

# Pull and run anywhere
docker run -p 8080:8080 yourusername/blog-app:latest
```

### Deploy to Cloud (AWS EC2 example)
```bash
# SSH into your EC2 instance
ssh -i your-key.pem ec2-user@your-instance-ip

# Clone repository
git clone <repository-url>
cd blog-management-system

# Run with Docker Compose
docker-compose up -d
```

### Deploy to Heroku
```bash
# Create Heroku app
heroku create your-blog-app

# Set environment variables
heroku config:set DATABASE_URL=<your-postgres-url>
heroku config:set JWT_SECRET=<your-secret>

# Deploy
git push heroku main
```

---

## 👥 Contributing

We love contributions! Whether it's bug fixes, new features, or improvements:

1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b feature/amazing-feature`
3. **Commit** your changes: `git commit -m 'Add amazing feature'`
4. **Push** to the branch: `git push origin feature/amazing-feature`
5. **Open** a Pull Request with a clear description

### Development Tips
- Follow the existing code style and naming conventions
- Write tests for new features
- Update documentation for changes
- Keep commits atomic and descriptive

---

## 📚 Learning Resources

New to Spring Boot or Java? Check these resources:

- [Spring Boot Official Docs](https://spring.io/projects/spring-boot)
- [Spring Security Guide](https://spring.io/guides/gs/securing-web/)
- [JPA/Hibernate Best Practices](https://hibernate.org/orm/documentation/)
- [JWT Authentication](https://jwt.io/)
- [Maven Documentation](https://maven.apache.org/guides/)

---

## 📝 License

This project is licensed under the **MIT License** - feel free to use it for personal or commercial projects.

---

## 💡 Tips & Best Practices

### During Development
- ✅ Use `application-dev.properties` for local config
- ✅ Enable hot reload: Add Spring DevTools to `pom.xml`
- ✅ Use Postman or Swagger UI to test APIs
- ✅ Write tests as you code

### Before Production
- ✅ Change all default passwords and secrets
- ✅ Enable HTTPS/SSL
- ✅ Set up proper logging and monitoring
- ✅ Run full test suite
- ✅ Configure database backups
- ✅ Review security settings

### Performance Optimization
- ✅ Enable response caching for frequently accessed content
- ✅ Use database indexing on frequently queried columns
- ✅ Implement pagination for large datasets
- ✅ Monitor application metrics with Spring Actuator

---

## 🤝 Support & Questions

- 📧 **Email**: support@blogapp.com
- 💬 **Issues**: Open an issue on GitHub for bugs and features
- 📖 **Wiki**: Check our wiki for extended documentation
- 🐦 **Twitter**: Follow us for updates and announcements

---

## 🎉 Acknowledgments

This project was created as a Java Spring Boot learning resource and practical blogging platform. Built with ❤️ for developers who love clean code and best practices.

---

**Made with ❤️ | Happy Coding!**

### Option 2: Docker Setup

1. **Build and run with Docker Compose**
```bash
docker-compose up --build
```

This will:
- Start PostgreSQL container
- Build and start the Spring Boot application
- Expose the app on `http://localhost:8080`

2. **Stop the containers**
```bash
docker-compose down
```

## 📊 Database Migration

The application uses Flyway for database migrations. Migrations run automatically on startup.

Migration files are located in: `src/main/resources/db/migration/`

To create a new migration:
1. Create a new file: `V{version}__Description.sql`
2. Add your SQL statements
3. Restart the application

## 🔐 Authentication

The application uses JWT (JSON Web Tokens) for authentication.

### Signup
```bash
POST /api/auth/signup
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123",
  "username": "johndoe",
  "displayName": "John Doe"
}
```

### Login
```bash
POST /api/auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123"
}
```

Response includes JWT token:
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "user": { ... },
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

### Using the Token
Include the token in the Authorization header:
```
Authorization: Bearer <your-jwt-token>
```

## 📚 API Documentation

### Swagger UI
Access interactive API documentation at:
```
http://localhost:8080/swagger-ui.html
```

### OpenAPI JSON
```
http://localhost:8080/api-docs
```

## 🔑 Key API Endpoints

### Authentication
- `POST /api/auth/signup` - Create account
- `POST /api/auth/login` - Login

### Posts
- `GET /api/posts` - Get all published posts
- `GET /api/posts/{id}` - Get single post
- `POST /api/posts` - Create post (auth required)
- `PUT /api/posts/{id}` - Update post (auth required)
- `DELETE /api/posts/{id}` - Delete post (auth required)
- `POST /api/posts/{id}/publish` - Publish draft (auth required)
- `GET /api/posts/search?q=keyword` - Search posts
- `GET /api/posts/user/drafts` - Get user drafts (auth required)

### Comments
- `GET /api/comments/{postId}` - Get comments for post
- `POST /api/comments/{postId}` - Add comment (auth required)
- `PUT /api/comments/{id}` - Update comment (auth required)
- `DELETE /api/comments/{id}` - Delete comment (auth required)

### Claps (Likes)
- `POST /api/claps/{postId}` - Add clap (auth required)
- `DELETE /api/claps/{postId}` - Remove clap (auth required)
- `GET /api/claps/{postId}/count` - Get claps count
- `GET /api/claps/{postId}/user` - Check if user clapped (auth required)

### Bookmarks
- `POST /api/bookmarks/{postId}` - Bookmark post (auth required)
- `DELETE /api/bookmarks/{postId}` - Remove bookmark (auth required)
- `GET /api/bookmarks` - Get user bookmarks (auth required)
- `GET /api/bookmarks/{postId}/check` - Check bookmark status (auth required)

### Follow
- `POST /api/follow/users/{userId}` - Follow user (auth required)
- `DELETE /api/follow/users/{userId}` - Unfollow user (auth required)
- `GET /api/follow/users/{userId}/followers` - Get followers
- `GET /api/follow/users/{userId}/following` - Get following
- `POST /api/follow/topics/{topicId}` - Follow topic (auth required)
- `DELETE /api/follow/topics/{topicId}` - Unfollow topic (auth required)

### Topics
- `GET /api/topics` - Get all topics
- `GET /api/topics/trending` - Get trending topics
- `GET /api/topics/{slug}` - Get topic by slug
- `GET /api/topics/{id}/posts` - Get posts by topic
- `POST /api/topics` - Create topic (auth required)

### Users
- `GET /api/users/{id}` - Get user profile
- `GET /api/users/username/{username}` - Get user by username
- `GET /api/users/{id}/posts` - Get user posts
- `PUT /api/users/{id}` - Update profile (auth required)
- `PUT /api/users/{id}/password` - Change password (auth required)

### Notifications
- `GET /api/notifications` - Get notifications (auth required)
- `GET /api/notifications/unread-count` - Get unread count (auth required)
- `PUT /api/notifications/{id}/read` - Mark as read (auth required)
- `PUT /api/notifications/read-all` - Mark all as read (auth required)

## 🧪 Testing

### Run all tests
```bash
mvn test
```

### Run specific test class
```bash
mvn test -Dtest=AuthServiceTest
```

### Run with coverage
```bash
mvn clean test jacoco:report
```

## 🚀 Deployment

### Production Configuration

1. **Update application-prod.properties**
```properties
spring.datasource.url=${DATABASE_URL}
spring.datasource.username=${DATABASE_USERNAME}
spring.datasource.password=${DATABASE_PASSWORD}
jwt.secret=${JWT_SECRET}
spring.jpa.show-sql=false
spring.thymeleaf.cache=true
```

2. **Build production JAR**
```bash
mvn clean package -DskipTests
```

3. **Run with production profile**
```bash
java -jar target/blog-management-system-1.0.0.jar --spring.profiles.active=prod
```

### Docker Deployment

```bash
# Build image
docker build -t blog-management-system:1.0.0 .

# Run container
docker run -d \
  -p 8080:8080 \
  -e SPRING_DATASOURCE_URL=jdbc:postgresql://host:5432/blogdb \
  -e SPRING_DATASOURCE_USERNAME=postgres \
  -e SPRING_DATASOURCE_PASSWORD=password \
  -e JWT_SECRET=your-secret-key \
  blog-management-system:1.0.0
```

## 🔄 Migration from MERN Stack

### Key Changes

| MERN Component | Java Equivalent |
|----------------|-----------------|
| Node.js/Express | Spring Boot |
| MongoDB | PostgreSQL |
| Mongoose | Spring Data JPA/Hibernate |
| JWT (jsonwebtoken) | JJWT Library |
| bcrypt | BCryptPasswordEncoder |
| Express middleware | Spring Security Filters |
| React Components | Thymeleaf Templates |
| React Router | Spring MVC |
| Axios/Fetch | RestTemplate/WebClient |

### Data Migration Steps

1. **Export data from MongoDB**
```bash
mongoexport --db=blogdb --collection=users --out=users.json
mongoexport --db=blogdb --collection=posts --out=posts.json
```

2. **Transform and import to PostgreSQL**
- Use provided migration scripts in `/migration-scripts/`
- Or manually transform JSON to SQL INSERT statements

3. **Verify data integrity**
```bash
psql -U postgres -d blogdb -c "SELECT COUNT(*) FROM users;"
psql -U postgres -d blogdb -c "SELECT COUNT(*) FROM posts;"
```

## 🛡️ Security Features

- JWT-based authentication
- Password encryption with BCrypt
- CORS configuration
- SQL injection prevention (JPA/Hibernate)
- XSS protection
- CSRF protection (for form submissions)
- Role-based access control (USER, ADMIN)
- Input validation

## 📈 Performance Optimization

- Database indexing on frequently queried columns
- Lazy loading for entity relationships
- Connection pooling (HikariCP)
- Query optimization with JPA
- Caching with Spring Cache (optional)

## 🐛 Troubleshooting

### Database Connection Issues
```bash
# Check PostgreSQL is running
pg_isready -h localhost -p 5432

# Check connection
psql -U postgres -d blogdb
```

### Port Already in Use
```bash
# Find process using port 8080
lsof -i :8080

# Kill the process
kill -9 <PID>
```

### Flyway Migration Errors
```bash
# Repair Flyway schema
mvn flyway:repair

# Clean and re-run migrations (WARNING: deletes all data)
mvn flyway:clean flyway:migrate
```

## 📝 License

This project is licensed under the MIT License.

## 👥 Contributors

- Development Team

## 📞 Support

For issues and questions:
- Create an issue on GitHub
- Email: support@blogapp.com

## 🎯 Future Enhancements

- [ ] OAuth2 integration (Google, GitHub)
- [ ] Email verification
- [ ] Password reset functionality
- [ ] Rich text editor integration
- [ ] Image upload to cloud storage
- [ ] Real-time notifications with WebSocket
- [ ] Full-text search with Elasticsearch
- [ ] Redis caching
- [ ] Rate limiting
- [ ] Admin dashboard
- [ ] Analytics and reporting
