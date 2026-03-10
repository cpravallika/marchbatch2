# QUICK START - Add Secrets Manually (5 Minutes)

## Step 1: Get Your Docker Hub Token (1 minute)

1. Go to: https://hub.docker.com/settings/security
2. Click **"New Access Token"**
3. Name it: `github-actions`
4. Click **"Generate"**
5. **Copy the token** (save it somewhere temporarily)

## Step 2: Add Secrets to GitHub (2 minutes)

### Option A: Using GitHub Web UI (Easiest)

1. Go to: https://github.com/cpravallika/marchbatch2/settings/secrets/actions

2. Click **"New repository secret"** button

3. **First Secret:**
   - Name: `DOCKERHUB_USERNAME`
   - Value: `pravallikac`
   - Click **"Add secret"**

4. **Second Secret:**
   - Name: `DOCKERHUB_TOKEN`
   - Value: (paste token from Step 1)
   - Click **"Add secret"**

### Option B: Using GitHub CLI (If installed)

```powershell
# Login first (if not already logged in)
gh auth login

# Add secrets
echo "pravallikac" | gh secret set DOCKERHUB_USERNAME --repo cpravallika/marchbatch2
echo "your-token-here" | gh secret set DOCKERHUB_TOKEN --repo cpravallika/marchbatch2
```

## Step 3: Verify Secrets (1 minute)

1. Go to: https://github.com/cpravallika/marchbatch2/actions
2. Click **"Verify Secrets"** workflow
3. Click **"Run workflow"** button
4. Wait for completion - should show ✅ ✅

## Step 4: Test Build (1 minute)

1. Go to Actions tab
2. Click **"Build and Push Docker Image"**
3. Click **"Run workflow"** button
4. Watch the logs - should build and push successfully

## Done! 🎉

Your Docker Hub image should now be updated automatically on every push!

