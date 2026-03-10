#!/bin/bash

# GitHub CLI Secret Setup Script
# This script adds Docker Hub credentials as GitHub secrets

echo "GitHub Secret Setup for Docker Hub"
echo "===================================="

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI is not installed. Please install it from: https://cli.github.com/"
    exit 1
fi

# Check if user is logged in to GitHub CLI
gh auth status > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "❌ Not logged in to GitHub CLI. Please run: gh auth login"
    exit 1
fi

echo ""
read -p "Enter your Docker Hub username: " DOCKERHUB_USERNAME
read -sp "Enter your Docker Hub token/password: " DOCKERHUB_TOKEN
echo ""

if [ -z "$DOCKERHUB_USERNAME" ] || [ -z "$DOCKERHUB_TOKEN" ]; then
    echo "❌ Username or token cannot be empty!"
    exit 1
fi

# Get current repo
REPO=$(gh repo view --json nameWithOwner -q)
if [ -z "$REPO" ]; then
    echo "❌ Could not determine repository. Make sure you're in a git repository."
    exit 1
fi

echo ""
echo "Adding secrets to repository: $REPO"
echo ""

# Add secrets
echo "Adding DOCKERHUB_USERNAME secret..."
echo "$DOCKERHUB_USERNAME" | gh secret set DOCKERHUB_USERNAME --repo "$REPO"

echo "Adding DOCKERHUB_TOKEN secret..."
echo "$DOCKERHUB_TOKEN" | gh secret set DOCKERHUB_TOKEN --repo "$REPO"

echo ""
echo "✅ Secrets added successfully!"
echo ""
echo "To verify, run: gh secret list --repo $REPO"

