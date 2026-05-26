# Database Setup PowerShell Script
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Database Setup for Blog Management System" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Database configuration
$dbName = "ashube"
$dbUser = "ashube"
$dbPassword = "05747674"
$dbHost = "localhost"
$dbPort = "3306"

# Find MySQL executable
$mysqlPaths = @(
    "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe",
    "C:\Program Files\MySQL\MySQL Server 8.4\bin\mysql.exe",
    "C:\xampp\mysql\bin\mysql.exe",
    "C:\wamp64\bin\mysql\mysql8.0.27\bin\mysql.exe",
    "C:\MySQL\bin\mysql.exe"
)

$mysqlExe = $null
foreach ($path in $mysqlPaths) {
    if (Test-Path $path) {
        $mysqlExe = $path
        Write-Host "✅ Found MySQL at: $path" -ForegroundColor Green
        break
    }
}

if (-not $mysqlExe) {
    # Try to find mysql in PATH
    $mysqlExe = (Get-Command mysql -ErrorAction SilentlyContinue).Source
    if ($mysqlExe) {
        Write-Host "✅ Found MySQL in PATH: $mysqlExe" -ForegroundColor Green
    } else {
        Write-Host "❌ MySQL not found!" -ForegroundColor Red
        Write-Host ""
        Write-Host "Please install MySQL or add it to your PATH" -ForegroundColor Yellow
        Write-Host "Common installation locations checked:" -ForegroundColor Yellow
        foreach ($path in $mysqlPaths) {
            Write-Host "  - $path" -ForegroundColor Gray
        }
        Write-Host ""
        Read-Host "Press Enter to exit"
        exit 1
    }
}

Write-Host ""
Write-Host "Step 1: Testing if user '$dbUser' already exists..." -ForegroundColor Yellow

# Test if user can connect
$testConnection = "SELECT 'User exists' as Status;"
$tempFile = [System.IO.Path]::GetTempFileName()
$testConnection | Out-File -FilePath $tempFile -Encoding ASCII

$result = & $mysqlExe -h $dbHost -P $dbPort -u $dbUser "-p$dbPassword" -e $testConnection 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ User '$dbUser' exists and can connect!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Step 2: Ensuring database '$dbName' exists..." -ForegroundColor Yellow
    
    $createDb = "CREATE DATABASE IF NOT EXISTS $dbName CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; USE $dbName; SELECT 'Database ready' as Status;"
    $result = & $mysqlExe -h $dbHost -P $dbPort -u $dbUser "-p$dbPassword" -e $createDb 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Database '$dbName' is ready!" -ForegroundColor Green
        Write-Host ""
        Write-Host "Step 3: Checking existing tables..." -ForegroundColor Yellow
        
        $showTables = "SHOW TABLES;"
        & $mysqlExe -h $dbHost -P $dbPort -u $dbUser "-p$dbPassword" $dbName -e $showTables
        
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "✅ SETUP COMPLETE!" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "Database Configuration:" -ForegroundColor Cyan
        Write-Host "  Database: $dbName" -ForegroundColor White
        Write-Host "  User: $dbUser" -ForegroundColor White
        Write-Host "  Password: $dbPassword" -ForegroundColor White
        Write-Host "  Host: $dbHost" -ForegroundColor White
        Write-Host "  Port: $dbPort" -ForegroundColor White
        Write-Host ""
        Write-Host "Next Steps:" -ForegroundColor Cyan
        Write-Host "  1. Run the Spring Boot application:" -ForegroundColor White
        Write-Host "     mvnw.cmd spring-boot:run" -ForegroundColor Gray
        Write-Host "  2. Access Swagger UI:" -ForegroundColor White
        Write-Host "     http://localhost:8080/swagger-ui.html" -ForegroundColor Gray
        Write-Host ""
    } else {
        Write-Host "❌ Could not create/access database" -ForegroundColor Red
        Write-Host $result -ForegroundColor Red
    }
} else {
    Write-Host "⚠️  User '$dbUser' does not exist yet" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Step 2: Creating database and user..." -ForegroundColor Yellow
    Write-Host "You will need your MySQL root password" -ForegroundColor Yellow
    Write-Host ""
    
    # Create SQL setup file
    $setupSQL = @"
CREATE DATABASE IF NOT EXISTS $dbName CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '$dbUser'@'localhost' IDENTIFIED BY '$dbPassword';
CREATE USER IF NOT EXISTS '$dbUser'@'%' IDENTIFIED BY '$dbPassword';
GRANT ALL PRIVILEGES ON $dbName.* TO '$dbUser'@'localhost';
GRANT ALL PRIVILEGES ON $dbName.* TO '$dbUser'@'%';
FLUSH PRIVILEGES;
SELECT 'Setup complete!' as Status;
"@
    
    $setupFile = "temp_setup.sql"
    $setupSQL | Out-File -FilePath $setupFile -Encoding ASCII
    
    Write-Host "Enter MySQL root password:" -ForegroundColor Cyan
    $rootPassword = Read-Host -AsSecureString
    $rootPasswordPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
        [Runtime.InteropServices.Marshal]::SecureStringToBSTR($rootPassword)
    )
    
    if ($rootPasswordPlain) {
        $result = Get-Content $setupFile | & $mysqlExe -h $dbHost -P $dbPort -u root "-p$rootPasswordPlain" 2>&1
    } else {
        $result = Get-Content $setupFile | & $mysqlExe -h $dbHost -P $dbPort -u root 2>&1
    }
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✅ Database and user created successfully!" -ForegroundColor Green
        Write-Host ""
        Write-Host "Step 3: Testing connection..." -ForegroundColor Yellow
        
        $testConn = "USE $dbName; SELECT 'Connection successful!' as Status;"
        $result = & $mysqlExe -h $dbHost -P $dbPort -u $dbUser "-p$dbPassword" -e $testConn 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Connection test passed!" -ForegroundColor Green
            Write-Host ""
            Write-Host "========================================" -ForegroundColor Green
            Write-Host "✅ SETUP COMPLETE!" -ForegroundColor Green
            Write-Host "========================================" -ForegroundColor Green
            Write-Host ""
            Write-Host "Database Configuration:" -ForegroundColor Cyan
            Write-Host "  Database: $dbName" -ForegroundColor White
            Write-Host "  User: $dbUser" -ForegroundColor White
            Write-Host "  Password: $dbPassword" -ForegroundColor White
            Write-Host ""
            Write-Host "Your Spring Boot application is ready to run!" -ForegroundColor Green
        } else {
            Write-Host "❌ Connection test failed" -ForegroundColor Red
            Write-Host $result -ForegroundColor Red
        }
    } else {
        Write-Host ""
        Write-Host "❌ Setup failed" -ForegroundColor Red
        Write-Host $result -ForegroundColor Red
        Write-Host ""
        Write-Host "Please check:" -ForegroundColor Yellow
        Write-Host "  1. MySQL is running" -ForegroundColor White
        Write-Host "  2. You have root access" -ForegroundColor White
        Write-Host "  3. You entered the correct password" -ForegroundColor White
    }
    
    # Clean up
    if (Test-Path $setupFile) {
        Remove-Item $setupFile
    }
}

Write-Host ""
Read-Host "Press Enter to exit"
