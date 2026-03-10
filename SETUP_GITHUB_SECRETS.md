# Setup GitHub Secrets - Dynamic Configuration Guide

This guide explains how to add Docker Hub credentials as GitHub secrets dynamically using GitHub CLI.

## Prerequisites

### 1. Install GitHub CLI
- **Windows (Chocolatey):**
  ```powershell
  choco install gh
  ```
- **Windows (Winget):**
  ```powershell
  winget install GitHub.cli
  ```
- **Download:** https://cli.github.com/

### 2. Login to GitHub CLI
```powershell
gh auth login
```
Follow the prompts:
- Choose "GitHub.com"
- Choose "HTTPS"
- Authenticate with browser

## Method 1: Automatic Setup (Recommended)

### Windows PowerShell
```powershell
# Navigate to your repository
cd C:\Users\monuc\OneDrive\Pravallika\GitRepository-test\marchbatch2

# Run the setup script
.\setup-secrets.ps1
```

### Linux/Mac Bash
```bash
cd ~/your-repo-path
bash setup-secrets.sh
```

The script will prompt you for:
1. Docker Hub username (e.g., `pravallikac`)
2. Docker Hub token/password

## Method 2: Manual Setup via GitHub CLI

```powershell
# Set DOCKERHUB_USERNAME
echo "pravallikac" | gh secret set DOCKERHUB_USERNAME --repo cpravallika/marchbatch2

# Set DOCKERHUB_TOKEN
echo "your-token-here" | gh secret set DOCKERHUB_TOKEN --repo cpravallika/marchbatch2
```

## Method 3: GitHub Web UI

1. Go to: https://github.com/cpravallika/marchbatch2/settings/secrets/actions
2. Click **New repository secret**
3. Add `DOCKERHUB_USERNAME`:
   - Name: `DOCKERHUB_USERNAME`
   - Secret: `pravallikac`
   - Click **Add secret**
4. Add `DOCKERHUB_TOKEN`:
   - Name: `DOCKERHUB_TOKEN`
   - Secret: (your Docker Hub token)
   - Click **Add secret**

## Verify Secrets

```powershell
gh secret list --repo cpravallika/marchbatch2
```

You should see:
```
DOCKERHUB_TOKEN          Updated 2026-03-10
DOCKERHUB_USERNAME       Updated 2026-03-10
```

## Getting Docker Hub Token

1. Go to: https://hub.docker.com/settings/security
2. Click **New Access Token**
3. Name: `github-actions`
4. Permissions: Read/Write
5. Click **Generate**
6. **Copy the token immediately** (won't be shown again)

## Test the Pipeline

1. Go to: https://github.com/cpravallika/marchbatch2/actions
2. Click **"Verify Secrets"** workflow
3. Click **Run workflow** (blue button)
4. Monitor - should show ✅ for both secrets

## Troubleshooting

### "User is not authenticated"
```powershell
gh auth login
```

### "Could not determine repository"
Make sure you're in the correct directory:
```powershell
cd C:\Users\monuc\OneDrive\Pravallika\GitRepository-test\marchbatch2
gh repo view
```

### Secrets not showing up
Wait 30 seconds for GitHub to sync, then refresh the page.

## Update Secrets

To update a secret, just re-run the script or use:
```powershell
echo "new-token" | gh secret set DOCKERHUB_TOKEN --repo cpravallika/marchbatch2
```

## Important Notes

- Secrets are **encrypted** and not visible in logs
- They are **repository-specific** (only used in this repo)
- They expire based on your Docker Hub token expiration
- Keep your Docker Hub token **private** and **secure**

