# 🚀 Deploying to Cloudflare Pages

This guide will help you deploy your Bijoy to Unicode Converter to Cloudflare Pages.

## Prerequisites

- A GitHub account
- A Cloudflare account (free tier works fine)
- Git installed on your computer

## Method 1: Deploy via GitHub (Recommended)

### Step 1: Create a GitHub Repository

1. Go to [GitHub](https://github.com) and log in
2. Click the "+" icon in the top right and select "New repository"
3. Name your repository (e.g., `bijoy-unicode-converter`)
4. Choose "Public" or "Private" (both work with Cloudflare Pages)
5. **DO NOT** initialize with README, .gitignore, or license (we already have these)
6. Click "Create repository"

### Step 2: Push Your Code to GitHub

Open your terminal in the project directory and run:

```bash
# Initialize git (if not already done)
git init

# Add all files
git add .

# Commit your files
git commit -m "Initial commit: Bijoy to Unicode Converter"

# Add your GitHub repository as remote (replace with your actual repo URL)
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git

# Push to GitHub
git branch -M main
git push -u origin main
```

### Step 3: Connect to Cloudflare Pages

1. Log in to your [Cloudflare Dashboard](https://dash.cloudflare.com/)
2. Click on "Workers & Pages" in the left sidebar
3. Click "Create application"
4. Select the "Pages" tab
5. Click "Connect to Git"
6. Authorize Cloudflare to access your GitHub account
7. Select your repository from the list
8. Click "Begin setup"

### Step 4: Configure Build Settings

In the build configuration page, enter these settings:

```
Project name: bijoy-unicode-converter (or your preferred name)
Production branch: main
Framework preset: Vite
Build command: npm run build
Build output directory: dist
```

**Important Build Settings:**
- Root directory: `/` (leave as default)
- Environment variables: None needed

### Step 5: Deploy

1. Click "Save and Deploy"
2. Wait for the build to complete (usually 1-3 minutes)
3. Once deployed, you'll get a URL like: `https://bijoy-unicode-converter.pages.dev`

## Method 2: Direct Upload (Quick & Easy)

If you don't want to use GitHub:

1. Build your project locally:
   ```bash
   npm install
   npm run build
   ```

2. Go to Cloudflare Dashboard → Workers & Pages → Create application
3. Select the "Pages" tab
4. Click "Upload assets"
5. Name your project
6. Drag and drop the entire `dist` folder
7. Click "Deploy site"

## Troubleshooting

### Build Fails with "Module not found"

**Solution:** Make sure all dependencies are in `package.json`. The file should include:
```json
{
  "dependencies": {
    "react": "^18.3.1",
    "react-dom": "^18.3.1",
    "lucide-react": "^0.263.1",
    "bijoy-to-unicode-bengali-conversion": "^0.1.4"
  }
}
```

### "npm: command not found" Error

**Solution:** Cloudflare Pages uses Node.js 16+ by default. If issues persist:
1. Go to your project settings in Cloudflare
2. Under "Build settings" → "Environment variables"
3. Add: `NODE_VERSION` = `18`

### Build Command Fails

**Solution:** Try these alternative build commands in order:
1. `npm install && npm run build`
2. `npm ci && npm run build`
3. `yarn install && yarn build`

### Blank Page After Deployment

**Solution:** Check these:
1. Ensure `dist` directory is set as build output
2. Verify `index.html` exists in dist after building
3. Check browser console for errors
4. Make sure `vite.config.js` has correct base path

### Missing CSS/Styling

**Solution:** Verify these files exist:
- `tailwind.config.js`
- `postcss.config.js`
- `index.css` imports Tailwind directives

## Post-Deployment

### Custom Domain (Optional)

1. In your Cloudflare Pages project, go to "Custom domains"
2. Click "Set up a custom domain"
3. Enter your domain name
4. Follow the DNS configuration instructions

### Environment Variables (If Needed)

Currently, this app doesn't need any environment variables. If you add features that require them:
1. Go to your project settings
2. Click "Environment variables"
3. Add variables for Production/Preview as needed

## Updating Your Deployment

### Via GitHub:
Just push to your main branch:
```bash
git add .
git commit -m "Update: description of changes"
git push
```
Cloudflare automatically rebuilds and deploys.

### Via Direct Upload:
1. Build locally: `npm run build`
2. Go to your project in Cloudflare
3. Click "Create new deployment"
4. Upload the new `dist` folder

## Performance Tips

1. **Enable caching:** Cloudflare automatically caches static assets
2. **Use custom domain:** Better for SEO and branding
3. **Monitor analytics:** Check "Web Analytics" in Cloudflare dashboard

## Common Cloudflare Pages Commands

```bash
# Install dependencies
npm install

# Run development server
npm run dev

# Build for production
npm run build

# Preview production build locally
npm run preview
```

## Getting Help

If you encounter issues:
1. Check the [Cloudflare Pages Docs](https://developers.cloudflare.com/pages/)
2. Review build logs in Cloudflare Dashboard
3. Check browser console for runtime errors
4. Verify all files are committed to Git

## Success! 🎉

Your Bijoy to Unicode Converter should now be live on Cloudflare Pages. Share your link and help others convert their text!

---

**Need to make changes?** Just edit your code, commit, and push. Cloudflare automatically deploys updates in seconds!
