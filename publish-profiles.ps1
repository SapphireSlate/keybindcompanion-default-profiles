# Publish KeybindCompanion Default Profiles to GitHub
# Usage: .\publish-profiles.ps1 -Message "Your commit message" [-DryRun]

param(
    [Parameter(Mandatory=$false)]
    [string]$Message = "Update profiles",
    
    [Parameter(Mandatory=$false)]
    [switch]$DryRun = $false
)

$ErrorActionPreference = "Stop"
$REPO_URL = "https://github.com/SapphireSlate/keybindcompanion-default-profiles.git"
$SCRIPT_DIR = $PSScriptRoot

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  KeybindCompanion Profile Publisher" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Check if git is installed
try {
    $gitVersion = git --version
    Write-Host "[OK] Git detected: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Git is not installed!" -ForegroundColor Red
    Write-Host "  Please install Git from: https://git-scm.com/download/win" -ForegroundColor Yellow
    exit 1
}

# Navigate to the profiles directory
Set-Location $SCRIPT_DIR
Write-Host "Working directory: $SCRIPT_DIR" -ForegroundColor Cyan
Write-Host ""

# Check if this is a git repository
$isGitRepo = Test-Path ".git"

if (-not $isGitRepo) {
    Write-Host "[WARNING] This folder is not a Git repository yet." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Would you like to initialize it and set up the remote? (y/n)" -ForegroundColor Yellow
    $response = Read-Host
    
    if ($response -eq "y" -or $response -eq "Y") {
        Write-Host ""
        Write-Host "Initializing Git repository..." -ForegroundColor Cyan
        git init
        
        Write-Host "Setting up remote 'origin'..." -ForegroundColor Cyan
        git remote add origin $REPO_URL
        
        Write-Host "Setting default branch to 'main'..." -ForegroundColor Cyan
        git branch -M main
        
        Write-Host ""
        Write-Host "[OK] Git repository initialized!" -ForegroundColor Green
        Write-Host "[OK] Remote 'origin' set to: $REPO_URL" -ForegroundColor Green
        Write-Host ""
        Write-Host "[INFO] Make sure you have authentication set up:" -ForegroundColor Yellow
        Write-Host "   Option 1: SSH key (recommended)" -ForegroundColor White
        Write-Host "   Option 2: Personal Access Token" -ForegroundColor White
        Write-Host "   Option 3: GitHub CLI (gh auth login)" -ForegroundColor White
        Write-Host ""
        Write-Host "   See: https://docs.github.com/en/authentication" -ForegroundColor White
        Write-Host ""
    } else {
        Write-Host "Aborted. Please initialize Git manually." -ForegroundColor Red
        exit 1
    }
}

# Check git status
Write-Host "Checking for changes..." -ForegroundColor Cyan
$status = git status --porcelain

if (-not $status) {
    Write-Host "[OK] No changes to commit. Everything is up to date!" -ForegroundColor Green
    Write-Host ""
    exit 0
}

Write-Host ""
Write-Host "Changes detected:" -ForegroundColor Yellow
Write-Host $status
Write-Host ""

# Show what will be committed
Write-Host "Files to be committed:" -ForegroundColor Cyan
git status --short
Write-Host ""

if ($DryRun) {
    Write-Host "[DRY RUN] No changes will be pushed" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Would commit with message: '$Message'" -ForegroundColor White
    Write-Host "Would push to: $REPO_URL" -ForegroundColor White
    Write-Host ""
    Write-Host "Run without -DryRun to actually publish." -ForegroundColor Cyan
    exit 0
}

# Confirm with user
Write-Host "Commit message: " -NoNewline -ForegroundColor Cyan
Write-Host "'$Message'" -ForegroundColor White
Write-Host ""
Write-Host "Ready to commit and push? (y/n)" -ForegroundColor Yellow
$confirm = Read-Host

if ($confirm -ne "y" -and $confirm -ne "Y") {
    Write-Host "Aborted by user." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Staging changes..." -ForegroundColor Cyan
git add .

Write-Host "Committing changes..." -ForegroundColor Cyan
git commit -m "$Message"

Write-Host "Pushing to GitHub..." -ForegroundColor Cyan
Write-Host ""

try {
    git push origin main
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Green
    Write-Host "  [SUCCESS] Published to GitHub!" -ForegroundColor Green
    Write-Host "================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Your profiles are now live at:" -ForegroundColor White
    Write-Host "https://github.com/SapphireSlate/keybindcompanion-default-profiles" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Users will receive updates within 5 seconds of app startup!" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host ""
    Write-Host "[ERROR] Failed to push to GitHub!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "Common issues:" -ForegroundColor Yellow
    Write-Host "  1. Authentication not set up" -ForegroundColor White
    Write-Host "  2. No internet connection" -ForegroundColor White
    Write-Host "  3. Repository permissions issue" -ForegroundColor White
    Write-Host ""
    Write-Host "To set up authentication:" -ForegroundColor Cyan
    Write-Host "  Option 1: gh auth login" -ForegroundColor White
    Write-Host "  Option 2: Set up SSH key" -ForegroundColor White
    Write-Host "  Option 3: Use Personal Access Token" -ForegroundColor White
    Write-Host ""
    Write-Host "Documentation:" -ForegroundColor Gray
    Write-Host "  https://docs.github.com/en/authentication" -ForegroundColor Gray
    Write-Host ""
    exit 1
}
