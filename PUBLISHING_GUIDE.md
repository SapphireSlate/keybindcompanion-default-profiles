# Publishing Profiles to GitHub - Quick Guide

## 🚀 Quick Start

### Option 1: PowerShell Script (Recommended)
```powershell
# Navigate to the profiles folder
cd keybindcompanion-default-profiles

# Publish with custom message
.\publish-profiles.ps1 -Message "Update CS2 and Valorant to v2.0.0"

# Quick publish with default message
.\publish-profiles.ps1

# Dry run (see what would happen without pushing)
.\publish-profiles.ps1 -Message "Testing" -DryRun
```

### Option 2: Batch File (Double-click)
```batch
# Just double-click: publish-profiles.bat
# Or with custom message:
publish-profiles.bat "Update CS2 and Valorant to v2.0.0"
```

---

## 🔧 First-Time Setup

### Step 1: Install Git (if not already installed)
Download and install from: https://git-scm.com/download/win

### Step 2: Set Up Authentication

Choose **ONE** of these methods:

#### Method A: GitHub CLI (Easiest) ⭐ RECOMMENDED
```powershell
# Install GitHub CLI
winget install --id GitHub.cli

# Login to GitHub
gh auth login
# Follow the prompts to authenticate
```

#### Method B: SSH Key
```powershell
# Generate SSH key
ssh-keygen -t ed25519 -C "your.email@example.com"

# Copy public key
cat ~/.ssh/id_ed25519.pub

# Add to GitHub: https://github.com/settings/keys
```

#### Method C: Personal Access Token
1. Go to: https://github.com/settings/tokens
2. Generate new token (classic)
3. Select scopes: `repo` (all sub-scopes)
4. Save the token securely
5. First push will ask for username & token

### Step 3: Run the Script
```powershell
cd keybindcompanion-default-profiles
.\publish-profiles.ps1
```

The script will:
- ✓ Initialize Git repo (if needed)
- ✓ Set up remote to GitHub
- ✓ Prompt for confirmation
- ✓ Commit and push changes

---

## 📝 Common Workflows

### Updating Existing Profiles
```powershell
# 1. Edit profiles in keybindcompanion-default-profiles/profiles/
# 2. Update manifest.json if needed
# 3. Run publish script
.\publish-profiles.ps1 -Message "Fix CS2 grenade keybinds"
```

### Adding New Game Profile
```powershell
# 1. Create new JSON: profiles/apex-default-v1.0.0.json
# 2. Add entry to manifest.json
# 3. Run publish script
.\publish-profiles.ps1 -Message "Add Apex Legends default profile"
```

### Version Bump
```powershell
# 1. Update version in profile JSON (e.g., 2.0.0 -> 2.1.0)
# 2. Update version in manifest.json
# 3. Update hardcoded version in src/main/db/defaultProfiles.ts
# 4. Run publish script
.\publish-profiles.ps1 -Message "Bump CS2 to v2.1.0 - add ping keybinds"
```

---

## 🔍 Script Features

### Dry Run Mode
See what would happen without actually pushing:
```powershell
.\publish-profiles.ps1 -Message "Test commit" -DryRun
```

### Smart Detection
- ✓ Detects if Git is installed
- ✓ Checks if repo is initialized
- ✓ Shows file changes before committing
- ✓ Confirms before pushing
- ✓ Provides helpful error messages

### Safety Features
- ✓ Asks for confirmation before pushing
- ✓ Shows exactly what will be committed
- ✓ Validates Git installation
- ✓ Clear error messages with solutions

---

## 📂 Folder Structure

```
keybindcompanion-default-profiles/
├── profiles/
│   ├── cs2-default-v2.0.0.json
│   ├── valorant-default-v2.0.0.json
│   └── ... other game profiles
├── manifest.json              # Version tracking
├── README.md                  # Repository documentation
├── publish-profiles.ps1       # Main PowerShell script
├── publish-profiles.bat       # Quick launcher
├── PUBLISHING_GUIDE.md        # This file
└── .git/                      # Git repository (created on first run)
```

---

## ⚡ Auto-Update Flow

After you publish to GitHub:

```
You Push to GitHub
      ↓
Within 5 seconds
      ↓
Users' Apps Check GitHub
      ↓
New Version Detected
      ↓
Auto-Download Profile
      ↓
Database Updated
      ↓
Users See New Keybinds! 🎉
```

---

## 🐛 Troubleshooting

### "Git is not installed"
**Solution:** Install Git from https://git-scm.com/download/win

### "Authentication failed"
**Solution:** Set up authentication (see First-Time Setup above)

### "Permission denied"
**Solution:** 
- Check you have write access to the repository
- Verify authentication is set up correctly
- Try: `gh auth login` to re-authenticate

### "Nothing to commit"
**Solution:** No changes detected. Edit profiles first!

### "Execution Policy Error"
**Solution:** Run PowerShell as Administrator:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Script Won't Run
**Solution:** Right-click `publish-profiles.ps1` → "Run with PowerShell"

Or use the batch file: Double-click `publish-profiles.bat`

---

## 📚 Advanced Usage

### Custom Commit Messages
```powershell
.\publish-profiles.ps1 -Message "Update CS2 v2.1.0: Fix buy menu keybind"
```

### Check Status Without Committing
```powershell
cd keybindcompanion-default-profiles
git status
```

### View Commit History
```powershell
git log --oneline
```

### Undo Last Commit (Before Push)
```powershell
git reset --soft HEAD~1
```

### Pull Latest Changes
```powershell
git pull origin main
```

---

## ✅ Best Practices

1. **Always sync hardcoded and GitHub versions**
   - Update `src/main/db/defaultProfiles.ts`
   - Update `keybindcompanion-default-profiles/profiles/*.json`
   - Keep version numbers identical

2. **Use semantic versioning**
   - Major: Breaking changes (1.0.0 → 2.0.0)
   - Minor: New features (2.0.0 → 2.1.0)
   - Patch: Bug fixes (2.1.0 → 2.1.1)

3. **Write clear commit messages**
   - Good: "Update CS2 v2.1.0: Add voice chat keybinds"
   - Bad: "Update"

4. **Test locally first**
   - Run app with updated hardcoded profiles
   - Verify keybinds work correctly
   - Then publish to GitHub

5. **Use dry run for complex changes**
   ```powershell
   .\publish-profiles.ps1 -Message "Major update" -DryRun
   ```

---

## 🎓 Example Workflow

Complete example of updating CS2 profile:

```powershell
# 1. Edit the hardcoded profile
code src/main/db/defaultProfiles.ts
# Update CS2 profile: add new keybind, bump version to 2.1.0

# 2. Edit the JSON profile
code keybindcompanion-default-profiles/profiles/cs2-default-v2.0.0.json
# Add same keybind, save as cs2-default-v2.1.0.json

# 3. Update manifest
code keybindcompanion-default-profiles/manifest.json
# Change version to 2.1.0, update filePath and timestamp

# 4. Test locally (optional but recommended)
# Run your app and verify the changes work

# 5. Publish to GitHub
cd keybindcompanion-default-profiles
.\publish-profiles.ps1 -Message "Update CS2 to v2.1.0: Add voice chat keybind"

# Done! Users will get the update within 5 seconds!
```

---

## 🔗 Useful Links

- **GitHub Repository:** https://github.com/SapphireSlate/keybindcompanion-default-profiles
- **GitHub Authentication:** https://docs.github.com/en/authentication
- **Git Documentation:** https://git-scm.com/doc
- **GitHub CLI:** https://cli.github.com/

---

## 💡 Tips

- **Keep it simple:** Just double-click `publish-profiles.bat` for quick updates
- **Use descriptive messages:** Future you will thank present you
- **Test before publishing:** Avoid pushing broken profiles
- **Version consistently:** Keep hardcoded and GitHub in sync
- **Document changes:** Add notes in commit messages

---

## 🎉 That's It!

You can now manage profiles from one workspace and publish to GitHub with a single command!

No more juggling multiple folders or using GitHub's web interface. 🚀

