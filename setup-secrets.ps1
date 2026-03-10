# GitHub Secret Setup Script for Docker Hub (Windows PowerShell)
# This script adds Docker Hub credentials as GitHub secrets dynamically

Write-Host "GitHub Secret Setup for Docker Hub" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan

# Check if GitHub CLI is installed
$ghPath = Get-Command gh -ErrorAction SilentlyContinue
if (-not $ghPath) {
    Write-Host "❌ GitHub CLI is not installed. Please install it from: https://cli.github.com/" -ForegroundColor Red
    exit 1
}

# Check if user is logged in to GitHub CLI
try {
    $authStatus = gh auth status 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Not logged in to GitHub CLI. Please run: gh auth login" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "❌ Error checking GitHub CLI authentication" -ForegroundColor Red
    exit 1
}

Write-Host ""
$DOCKERHUB_USERNAME = Read-Host "Enter your Docker Hub username"
$DOCKERHUB_TOKEN = Read-Host "Enter your Docker Hub token/password" -AsSecureString
$DOCKERHUB_TOKEN_PLAIN = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($DOCKERHUB_TOKEN))

if ([string]::IsNullOrWhiteSpace($DOCKERHUB_USERNAME) -or [string]::IsNullOrWhiteSpace($DOCKERHUB_TOKEN_PLAIN)) {
    Write-Host "❌ Username or token cannot be empty!" -ForegroundColor Red
    exit 1
}

# Get current repo
try {
    $REPO = gh repo view --json nameWithOwner -q
    if ([string]::IsNullOrWhiteSpace($REPO)) {
        Write-Host "❌ Could not determine repository. Make sure you're in a git repository." -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "❌ Error getting repository information" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Adding secrets to repository: $REPO" -ForegroundColor Yellow
Write-Host ""

# Add secrets
Write-Host "Adding DOCKERHUB_USERNAME secret..." -ForegroundColor Green
$DOCKERHUB_USERNAME | gh secret set DOCKERHUB_USERNAME --repo "$REPO"
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ DOCKERHUB_USERNAME added successfully!" -ForegroundColor Green
} else {
    Write-Host "❌ Failed to add DOCKERHUB_USERNAME" -ForegroundColor Red
}

Write-Host "Adding DOCKERHUB_TOKEN secret..." -ForegroundColor Green
$DOCKERHUB_TOKEN_PLAIN | gh secret set DOCKERHUB_TOKEN --repo "$REPO"
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ DOCKERHUB_TOKEN added successfully!" -ForegroundColor Green
} else {
    Write-Host "❌ Failed to add DOCKERHUB_TOKEN" -ForegroundColor Red
}

Write-Host ""
Write-Host "✅ Secrets setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "To verify secrets, run: gh secret list --repo $REPO" -ForegroundColor Cyan

