#!/bin/bash

# Bijoy Unicode Converter - Deployment Readiness Check
# This script verifies that all necessary files are present

echo "🔍 Checking deployment readiness..."
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

errors=0
warnings=0

# Check critical files
echo "📋 Checking critical files..."

files=(
  "index.html:HTML entry point"
  "main.jsx:React entry point"
  "App.jsx:Main App component"
  "BijoyConverter.jsx:Converter component"
  "index.css:Styles"
  "package.json:Dependencies"
  "vite.config.js:Vite config"
  "tailwind.config.js:Tailwind config"
  "postcss.config.js:PostCSS config"
)

for item in "${files[@]}"; do
  IFS=':' read -r file desc <<< "$item"
  if [ -f "$file" ]; then
    echo -e "${GREEN}✓${NC} $file ($desc)"
  else
    echo -e "${RED}✗${NC} $file ($desc) - MISSING!"
    ((errors++))
  fi
done

echo ""

# Check package.json dependencies
echo "📦 Checking package.json dependencies..."

if [ -f "package.json" ]; then
  if grep -q "\"react\"" package.json && \
     grep -q "\"react-dom\"" package.json && \
     grep -q "\"lucide-react\"" package.json && \
     grep -q "\"bijoy-to-unicode-bengali-conversion\"" package.json; then
    echo -e "${GREEN}✓${NC} All required dependencies present"
  else
    echo -e "${RED}✗${NC} Missing required dependencies!"
    ((errors++))
  fi
  
  if grep -q "\"vite\"" package.json && \
     grep -q "\"@vitejs/plugin-react\"" package.json && \
     grep -q "\"tailwindcss\"" package.json; then
    echo -e "${GREEN}✓${NC} All required devDependencies present"
  else
    echo -e "${RED}✗${NC} Missing required devDependencies!"
    ((errors++))
  fi
else
  echo -e "${RED}✗${NC} package.json not found!"
  ((errors++))
fi

echo ""

# Check if node_modules exists (should be gitignored)
echo "🗂️  Checking gitignore setup..."

if [ -f ".gitignore" ]; then
  if grep -q "node_modules" .gitignore && \
     grep -q "/dist" .gitignore; then
    echo -e "${GREEN}✓${NC} .gitignore properly configured"
  else
    echo -e "${YELLOW}⚠${NC}  .gitignore might need updating"
    ((warnings++))
  fi
else
  echo -e "${YELLOW}⚠${NC}  No .gitignore found"
  ((warnings++))
fi

echo ""

# Check for dist folder (should not be committed)
if [ -d "dist" ]; then
  echo -e "${YELLOW}⚠${NC}  dist/ folder exists (should be in .gitignore)"
  ((warnings++))
else
  echo -e "${GREEN}✓${NC} No dist/ folder (correct)"
fi

echo ""

# Check Git status
echo "🔧 Checking Git setup..."

if [ -d ".git" ]; then
  echo -e "${GREEN}✓${NC} Git initialized"
  
  # Check if there's a remote
  if git remote -v | grep -q "origin"; then
    echo -e "${GREEN}✓${NC} Git remote configured"
    git remote -v | head -n 1
  else
    echo -e "${YELLOW}⚠${NC}  No Git remote configured yet (you'll need to add one)"
    ((warnings++))
  fi
else
  echo -e "${YELLOW}⚠${NC}  Git not initialized (run: git init)"
  ((warnings++))
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Summary
if [ $errors -eq 0 ] && [ $warnings -eq 0 ]; then
  echo -e "${GREEN}✅ All checks passed!${NC}"
  echo "   Your project is ready for deployment to Cloudflare Pages!"
  echo ""
  echo "   Next steps:"
  echo "   1. git add ."
  echo "   2. git commit -m 'Initial commit'"
  echo "   3. git remote add origin <your-github-repo-url>"
  echo "   4. git push -u origin main"
  echo "   5. Connect to Cloudflare Pages"
elif [ $errors -eq 0 ]; then
  echo -e "${YELLOW}⚠️  Checks passed with warnings${NC}"
  echo "   Warnings: $warnings"
  echo "   You can still deploy, but review the warnings above."
else
  echo -e "${RED}❌ Checks failed!${NC}"
  echo "   Errors: $errors"
  echo "   Warnings: $warnings"
  echo "   Please fix the errors above before deploying."
fi

echo ""
