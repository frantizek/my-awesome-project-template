#!/usr/bin/env bash
# ──────────────────────────────────────────────────
# GitHub Labels Auto-Create Script
# Usage: bash scripts/create-labels.sh
# Requires: GitHub CLI (gh) authenticated
# ──────────────────────────────────────────────────

set -e

# Check if gh is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed."
    echo "   Install it: https://cli.github.com/"
    exit 1
fi

# Check if gh is authenticated
if ! gh auth status &> /dev/null; then
    echo "❌ GitHub CLI is not authenticated."
    echo "   Run: gh auth login"
    exit 1
fi

echo "🏷️  Creating GitHub labels..."
echo ""

# ──────────────── Delete default labels ────────────────
echo "🗑️  Removing default GitHub labels..."
gh label delete "bug" --yes 2>/dev/null || true
gh label delete "documentation" --yes 2>/dev/null || true
gh label delete "duplicate" --yes 2>/dev/null || true
gh label delete "enhancement" --yes 2>/dev/null || true
gh label delete "good first issue" --yes 2>/dev/null || true
gh label delete "help wanted" --yes 2>/dev/null || true
gh label delete "invalid" --yes 2>/dev/null || true
gh label delete "question" --yes 2>/dev/null || true
gh label delete "wontfix" --yes 2>/dev/null || true

# ──────────────── Type Labels ────────────────
echo ""
echo "📝 Creating Type labels..."
gh label create "bug"           --color "d73a4a" --description "Something isn't working" --force
gh label create "feature"       --color "a2eeef" --description "New feature request" --force
gh label create "enhancement"   --color "84b6eb" --description "Improvement to existing feature" --force
gh label create "documentation" --color "0075ca" --description "Documentation updates" --force
gh label create "question"      --color "d876e3" --description "Questions or discussions" --force
gh label create "task"          --color "fbca04" --description "General task or todo" --force

# ──────────────── Status Labels ────────────────
echo ""
echo "📊 Creating Status labels..."
gh label create "needs-triage"           --color "e4e669" --description "Needs initial review and categorization" --force
gh label create "needs-attention"        --color "b60205" --description "Requires immediate attention" --force
gh label create "needs-author-feedback"  --color "fbca04" --description "Waiting for response from author" --force
gh label create "in-progress"            --color "0e8a16" --description "Currently being worked on" --force
gh label create "blocked"                --color "b60205" --description "Blocked by another issue or dependency" --force
gh label create "ready-for-review"       --color "0075ca" --description "Ready for code review" --force

# ──────────────── Priority Labels ────────────────
echo ""
echo "🔥 Creating Priority labels..."
gh label create "priority-critical" --color "b60205" --description "Must fix immediately" --force
gh label create "priority-high"     --color "d73a4a" --description "Should fix soon" --force
gh label create "priority-medium"   --color "e99695" --description "Normal priority" --force
gh label create "priority-low"      --color "c5def5" --description "Nice to have, no rush" --force

# ──────────────── Area Labels ────────────────
echo ""
echo "📁 Creating Area labels..."
gh label create "area-api"    --color "1d76db" --description "API related" --force
gh label create "area-cli"    --color "1d76db" --description "CLI related" --force
gh label create "area-tests"  --color "1d76db" --description "Test related" --force
gh label create "area-ci"     --color "1d76db" --description "CI/CD pipeline related" --force
gh label create "area-docs"   --color "1d76db" --description "Documentation related" --force
gh label create "area-config" --color "1d76db" --description "Configuration related" --force

# ──────────────── Special Labels ────────────────
echo ""
echo "⭐ Creating Special labels..."
gh label create "help-wanted"     --color "008672" --description "Open for community contributions" --force
gh label create "good-first-issue" --color "7057ff" --description "Good for newcomers" --force
gh label create "duplicate"       --color "cfd3d7" --description "Already exists" --force
gh label create "wontfix"         --color "ffffff" --description "Will not be addressed" --force
gh label create "invalid"         --color "e4e669" --description "Not a valid issue" --force

echo ""
echo "✅ All labels created successfully!"
echo ""
echo "View them at: $(gh repo view --json url -q .url)/labels"
