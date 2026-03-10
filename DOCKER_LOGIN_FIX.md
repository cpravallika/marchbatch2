# Docker Login Fix Guide

## Issue: "Username and password required" Error

This error occurs when the GitHub secrets `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` are not properly configured.

## Solution Steps:

### Step 1: Create Docker Hub Personal Access Token
1. Go to: https://hub.docker.com/settings/security
2. Click **"New Access Token"**
3. Name it: `github-actions`
4. Click **"Generate"**
5. **Copy the token immediately** (you won't see it again)

### Step 2: Add Secrets to GitHub
1. Go to your repository: https://github.com/cpravallika/marchbatch2
2. Click **Settings** (top right)
3. Click **Secrets and variables** > **Actions** (left sidebar)
4. Click **New repository secret** (green button)

**Add First Secret:**
- Name: `DOCKERHUB_USERNAME`
- Secret: `pravallikac` (your Docker Hub username)
- Click **Add secret**

**Add Second Secret:**
- Name: `DOCKERHUB_TOKEN`
- Secret: (paste the token from Step 1)
- Click **Add secret**

### Step 3: Verify Secrets
1. Go to Actions tab: https://github.com/cpravallika/marchbatch2/actions
2. Click **"Verify Secrets"** workflow
3. Click **"Run workflow"** (blue button)
4. Wait for it to complete
5. Check if it shows ✅ for both secrets

### Step 4: Retry Build
1. Go to Actions tab
2. Click **"Build and Push Docker Image"** workflow
3. Click **"Run workflow"** (blue button)
4. Monitor the logs for success

## Verification
- Check Docker Hub: https://hub.docker.com/r/pravallikac/java-docker-sample123
- You should see the new image with tags `latest` and the commit SHA

## Still Having Issues?
- Ensure the token has push permissions (usually it does by default)
- Try regenerating a new token if the current one is old
- Check that you're using the correct Docker Hub username

