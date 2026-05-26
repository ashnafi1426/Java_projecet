# Direct Database Migration Script
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Database Migration Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$dbName = "ashube"
$dbUser = "ashube"
$dbPassword = "05747674"
$dbHost = "localhost"
$dbPort = "3306"

# Find MySQL
$mysqlExe = "C:\xampp\mysql\bin\mysql.exe"
if (-not (Test-Path $mysqlExe)) {
    $mysqlExe = (Get-Command mysql -ErrorAction SilentlyContinue).Source
}

if (-not $mysqlExe) {
    Write-Host "❌ MySQL not found" -ForegroundColor Red
    exit 1
}

Write-Host "Found MySQL at: $mysqlExe" -ForegroundColor Green
Write-Host ""
Write-Host "Database: $dbName" -ForegroundColor White
Write-Host "User: $dbUser" -ForegroundColor White
Write-Host "Host: ${dbHost}:${dbPort}" -ForegroundColor White
Write-Host ""

# Get migration files
$migrationPath = "src\main\resources\db\migration"
$migrationFiles = Get-ChildItem -Path $migrationPath -Filter "*.sql" | Sort-Object Name

Write-Host "Found $($migrationFiles.Count) migration files:" -ForegroundColor Yellow
foreach ($file in $migrationFiles) {
    Write-Host "  - $($file.Name)" -ForegroundColor Gray
}
Write-Host ""

$response = Read-Host "Do you want to proceed with migrations? (Y/N)"
if ($response -ne "Y" -and $response -ne "y") {
    Write-Host "Migration cancelled" -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "Creating Flyway schema history table..." -ForegroundColor Yellow

# Create flyway_schema_history table if it doesn't exist
$flywayTable = @"
CREATE TABLE IF NOT EXISTS flyway_schema_history (
    installed_rank INT NOT NULL,
    version VARCHAR(50),
    description VARCHAR(200) NOT NULL,
    type VARCHAR(20) NOT NULL,
    script VARCHAR(1000) NOT NULL,
    checksum INT,
    installed_by VARCHAR(100) NOT NULL,
    installed_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    execution_time INT NOT NULL,
    success BOOLEAN NOT NULL,
    PRIMARY KEY (installed_rank),
    INDEX flyway_schema_history_s_idx (success)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
"@

$flywayTable | & $mysqlExe -h $dbHost -P $dbPort -u $dbUser "-p$dbPassword" $dbName 2>&1 | Out-Null

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Flyway schema history table ready" -ForegroundColor Green
} else {
    Write-Host "❌ Failed to create Flyway table" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Running migrations..." -ForegroundColor Yellow
Write-Host ""

$successCount = 0
$failCount = 0

foreach ($file in $migrationFiles) {
    Write-Host "Executing: $($file.Name)..." -ForegroundColor Cyan
    
    $startTime = Get-Date
    $result = Get-Content $file.FullName | & $mysqlExe -h $dbHost -P $dbPort -u $dbUser "-p$dbPassword" $dbName 2>&1
    $endTime = Get-Date
    $executionTime = ($endTime - $startTime).TotalMilliseconds
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✅ Success" -ForegroundColor Green
        $successCount++
        
        # Extract version and description from filename
        if ($file.Name -match "V(\d+)__(.+)\.sql") {
            $version = $matches[1]
            $description = $matches[2].Replace("_", " ")
            
            # Record in flyway_schema_history
            $recordMigration = @"
INSERT INTO flyway_schema_history 
(installed_rank, version, description, type, script, checksum, installed_by, execution_time, success)
VALUES 
((SELECT COALESCE(MAX(installed_rank), 0) + 1 FROM flyway_schema_history AS fsh), 
'$version', '$description', 'SQL', '$($file.Name)', 0, '$dbUser', $([int]$executionTime), 1)
ON DUPLICATE KEY UPDATE installed_rank=installed_rank;
"@
            $recordMigration | & $mysqlExe -h $dbHost -P $dbPort -u $dbUser "-p$dbPassword" $dbName 2>&1 | Out-Null
        }
    } else {
        Write-Host "  ❌ Failed: $result" -ForegroundColor Red
        $failCount++
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Migration Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Total migrations: $($migrationFiles.Count)" -ForegroundColor White
Write-Host "Successful: $successCount" -ForegroundColor Green
Write-Host "Failed: $failCount" -ForegroundColor $(if ($failCount -gt 0) { "Red" } else { "Green" })
Write-Host ""

if ($failCount -eq 0) {
    Write-Host "✅ All migrations completed successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Checking created tables..." -ForegroundColor Yellow
    & $mysqlExe -h $dbHost -P $dbPort -u $dbUser "-p$dbPassword" $dbName -e "SHOW TABLES;"
    Write-Host ""
    Write-Host "Your database is ready for the application!" -ForegroundColor Green
} else {
    Write-Host "⚠️  Some migrations failed. Please check the errors above." -ForegroundColor Yellow
}

Write-Host ""
Read-Host "Press Enter to exit"
