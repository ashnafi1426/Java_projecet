# Blog Management System - Frontend Guide

## Overview

This project includes **TWO interfaces**:

1. **Backend REST API** (Spring Boot) - Port 8080
2. **Desktop Frontend** (JavaFX) - GUI Application

---

## Architecture

```
┌─────────────────────────────────────┐
│   Desktop Frontend (JavaFX)         │
│   - User Interface                  │
│   - Blog Reader                     │
│   - Post Editor                     │
│   - User Management                 │
└──────────────┬──────────────────────┘
               │ HTTP REST API
               ▼
┌─────────────────────────────────────┐
│   Backend API (Spring Boot)         │
│   - REST Controllers                │
│   - Business Logic                  │
│   - Authentication (JWT)            │
└──────────────┬──────────────────────┘
               │ JDBC
               ▼
┌─────────────────────────────────────┐
│   MySQL Database (ashube)           │
│   - Users, Posts, Comments          │
│   - Topics, Claps, Bookmarks        │
└─────────────────────────────────────┘
```

---

## Quick Start

### Option 1: Start Both Together (Recommended)

```bash
START_BOTH.bat
```

This will:
1. Start the backend API in one window
2. Wait 30 seconds for initialization
3. Start the desktop frontend in another window

### Option 2: Start Separately

**Terminal 1 - Backend:**
```bash
start-backend.bat
```

**Terminal 2 - Frontend (after backend is ready):**
```bash
start-frontend.bat
```

---

## Backend API (Spring Boot)

### Starting the Backend

```bash
start-backend.bat
```

### Backend URLs

Once started, access:

- **API Base:** http://localhost:8080/api
- **Swagger UI:** http://localhost:8080/swagger-ui.html
- **API Docs:** http://localhost:8080/api-docs
- **Health Check:** http://localhost:8080/actuator/health

### Backend Features

- RESTful API endpoints
- JWT authentication
- User management
- Blog post CRUD operations
- Comment system
- Social features (follow, clap, bookmark)
- Topic management
- Notification system

### API Endpoints

#### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user
- `POST /api/auth/logout` - Logout user

#### Posts
- `GET /api/posts` - Get all posts
- `GET /api/posts/{id}` - Get post by ID
- `POST /api/posts` - Create new post
- `PUT /api/posts/{id}` - Update post
- `DELETE /api/posts/{id}` - Delete post

#### Users
- `GET /api/users` - Get all users
- `GET /api/users/{id}` - Get user by ID
- `PUT /api/users/{id}` - Update user profile

#### Topics
- `GET /api/topics` - Get all topics
- `GET /api/topics/{id}` - Get topic by ID

#### Comments
- `GET /api/posts/{postId}/comments` - Get post comments
- `POST /api/posts/{postId}/comments` - Add comment

#### Social
- `POST /api/posts/{postId}/clap` - Clap for post
- `POST /api/posts/{postId}/bookmark` - Bookmark post
- `POST /api/users/{userId}/follow` - Follow user

---

## Desktop Frontend (JavaFX)

### Starting the Frontend

```bash
start-frontend.bat
```

**Prerequisites:**
- Backend must be running on port 8080
- JavaFX dependencies will be downloaded automatically

### Frontend Features

The desktop application provides a rich GUI with:

#### Main Views

1. **Home Feed**
   - Browse all published posts
   - Filter by topics
   - Search posts
   - View trending content

2. **Post Reader**
   - Read full blog posts
   - View author information
   - Clap for posts
   - Bookmark posts
   - Add comments

3. **Post Editor**
   - Create new posts
   - Edit existing posts
   - Rich text editing
   - Add cover images
   - Select topics
   - Save as draft or publish

4. **User Profile**
   - View user information
   - See user's posts
   - Follow/unfollow users
   - Edit profile

5. **Topics**
   - Browse topics
   - Follow topics
   - View topic-specific posts

6. **Notifications**
   - View notifications
   - Mark as read
   - Real-time updates

#### UI Components

- **Navigation Bar** - Quick access to main sections
- **Sidebar** - Topics and user info
- **Post Cards** - Preview posts with images
- **Comment List** - Nested comments display
- **User Cards** - User profiles and stats
- **Loading Spinners** - Visual feedback
- **Empty States** - Helpful messages

### Frontend Architecture

```
src/main/java/com/blogapp/desktop/
├── BlogDesktopApplication.java    # Main entry point
├── components/                     # Reusable UI components
│   ├── Avatar.java
│   ├── PostCard.java
│   ├── CommentList.java
│   ├── NavigationBar.java
│   └── ...
├── views/                          # Main application views
│   ├── HomeView.java
│   ├── PostDetailView.java
│   ├── CreatePostView.java
│   ├── ProfileView.java
│   └── ...
├── services/                       # API communication
│   ├── AuthService.java
│   ├── PostService.java
│   ├── UserService.java
│   └── ...
├── models/                         # Data models
│   ├── Post.java
│   ├── User.java
│   ├── Comment.java
│   └── ...
└── utils/                          # Utility classes
    └── DateFormatter.java
```

---

## Configuration

### Backend Configuration

File: `src/main/resources/application.properties`

```properties
# Server
server.port=8080

# Database
spring.datasource.url=jdbc:mysql://localhost:3306/ashube
spring.datasource.username=ashube
spring.datasource.password=05747674

# JWT
jwt.secret=your-256-bit-secret-key
jwt.expiration=86400000
```

### Frontend Configuration

The frontend automatically connects to:
- **Backend API:** http://localhost:8080

To change the API URL, modify the service classes in:
`src/main/java/com/blogapp/desktop/services/`

---

## Development Workflow

### 1. Start MySQL
Ensure XAMPP MySQL is running

### 2. Start Backend
```bash
start-backend.bat
```

Wait for:
```
Started BlogApplication in X.XXX seconds
```

### 3. Test Backend
Open: http://localhost:8080/swagger-ui.html

### 4. Start Frontend
```bash
start-frontend.bat
```

### 5. Use the Application
- Register a new user
- Create blog posts
- Add comments
- Follow users and topics

---

## Troubleshooting

### Backend Won't Start

**Issue:** Port 8080 already in use

**Solution:**
```bash
# Find process using port 8080
netstat -ano | findstr :8080

# Kill the process
taskkill /PID <process_id> /F
```

### Frontend Can't Connect

**Issue:** "Connection refused" or "Cannot connect to backend"

**Solution:**
1. Ensure backend is running
2. Check backend URL in service classes
3. Verify port 8080 is accessible

### JavaFX Not Loading

**Issue:** JavaFX dependencies not found

**Solution:**
```bash
# Clean and rebuild
mvnw.cmd clean install
mvnw.cmd javafx:run
```

### Database Connection Failed

**Issue:** Backend can't connect to database

**Solution:**
1. Start XAMPP MySQL
2. Verify database exists:
   ```bash
   verify-connection.bat
   ```
3. Check credentials in `application.properties`

---

## Building for Production

### Backend JAR

```bash
mvnw.cmd clean package
java -jar target/blog-management-system-1.0.0.jar
```

### Desktop Application

```bash
mvnw.cmd clean javafx:jlink
```

This creates a standalone application with bundled JRE.

---

## Features Checklist

### Backend API
- ✅ User authentication (JWT)
- ✅ User registration and login
- ✅ Blog post CRUD operations
- ✅ Comment system
- ✅ Clap/like system
- ✅ Bookmark system
- ✅ Follow users
- ✅ Follow topics
- ✅ Notifications
- ✅ Full-text search
- ✅ Swagger documentation

### Desktop Frontend
- ✅ User interface (JavaFX)
- ✅ Home feed
- ✅ Post reader
- ✅ Post editor
- ✅ User profiles
- ✅ Topic browsing
- ✅ Comment display
- ✅ Clap button
- ✅ Bookmark button
- ✅ Follow button
- ✅ Navigation bar
- ✅ Responsive layout

---

## Technology Stack

### Backend
- **Framework:** Spring Boot 3.2.5
- **Language:** Java 17+
- **Database:** MySQL 8.0 / MariaDB 10.4
- **ORM:** Hibernate / JPA
- **Security:** Spring Security + JWT
- **API Docs:** Swagger / OpenAPI
- **Build Tool:** Maven

### Frontend
- **Framework:** JavaFX 21
- **Language:** Java 17+
- **HTTP Client:** Java HttpClient
- **JSON:** Jackson
- **Build Tool:** Maven

---

## Next Steps

1. ✅ **Backend is starting** - Wait for initialization
2. 🎨 **Start the frontend** - Run `start-frontend.bat`
3. 👤 **Register a user** - Create your account
4. 📝 **Create a post** - Write your first blog
5. 💬 **Add comments** - Engage with content
6. 👏 **Clap for posts** - Show appreciation
7. 🔖 **Bookmark posts** - Save for later
8. 👥 **Follow users** - Build your network

---

## Support

### Check Status

**Backend:**
```bash
curl http://localhost:8080/actuator/health
```

**Database:**
```bash
verify-connection.bat
```

### View Logs

Logs are displayed in the terminal windows where you started the applications.

### Common Commands

```bash
# Start everything
START_BOTH.bat

# Start backend only
start-backend.bat

# Start frontend only
start-frontend.bat

# Verify database
verify-connection.bat

# Check database schema
verify-database-schema.bat
```

---

## 🎉 Enjoy Your Blog Management System!

You now have a full-stack blog application with:
- Modern REST API backend
- Rich desktop GUI frontend
- Complete blog features
- Social interactions
- User management

Happy blogging! 📝✨
