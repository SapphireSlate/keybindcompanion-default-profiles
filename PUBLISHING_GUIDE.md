# Publishing Profiles to GitHub - Simple Guide

## ✅ **Current Setup (Already Complete!)**

Your local `keybindcompanion-default-profiles/` folder is now a Git repository connected to:
**https://github.com/SapphireSlate/keybindcompanion-default-profiles**

---

## 🚀 **How to Publish Updates** (Super Simple)

### Method 1: PowerShell Script (Recommended)
```powershell
cd keybindcompanion-default-profiles
.\publish-profiles.ps1 -Message "Your update description"
```

### Method 2: Double-Click (Easiest!)
1. Open File Explorer
2. Navigate to `C:\Users\Cavso\Ayo\keybindcompanion-default-profiles\`
3. Double-click `publish-profiles.bat`
4. Enter your commit message when prompted

### Method 3: Manual Git Commands
```powershell
cd keybindcompanion-default-profiles
git add .
git commit -m "Your update description"
git push origin main
```

---

## 📝 **Complete Workflow Example**

### Scenario: Update CS2 Keybinds

```powershell
# 1. Edit the JSON profile
code profiles/cs2-default-v2.0.0.json
# Make your changes

# 2. Edit the hardcoded profile (keep them in sync!)
code ../src/main/db/defaultProfiles.ts
# Make matching changes

# 3. Update manifest if version changed
code manifest.json

# 4. Publish to GitHub
.\publish-profiles.ps1 -Message "Fix CS2 grenade keybinds"

# Done! Users get updates in 5 seconds!
```

---

## 🎯 **What the Script Does**

1. ✅ Checks if Git is installed
2. ✅ Shows what changed
3. ✅ Asks for confirmation
4. ✅ Commits changes
5. ✅ Pushes to GitHub
6. ✅ Shows success message

**That's it!** No cloning, no separate repos, no web interface needed.

---

## 🔧 **First-Time Authentication**

If you haven't set up GitHub authentication yet:

### Option A: GitHub CLI (Easiest)
```powershell
winget install --id GitHub.cli
gh auth login
```

### Option B: SSH Key
```powershell
ssh-keygen -t ed25519 -C "your.email@example.com"
# Add public key to: https://github.com/settings/keys
```

### Option C: Personal Access Token
- Generate at: https://github.com/settings/tokens
- Use when Git asks for password

---

## 📊 **Profile Keybind Counts (Updated)**

| Game | Version | Keybinds | Status |
|------|---------|----------|--------|
| **CS2** | v2.0.0 | **44** | ✅ Complete (Added Console) |
| **Valorant** | v2.0.0 | **37** | ✅ Complete (Added Inspect Weapon) |

### CS2 v2.0.0 - Complete Keybinds:
- Movement (7): W, A, S, D, Space, LCtrl, LShift
- Combat (7): LMB, RMB, R, E, G, F, Q
- Weapons (7): MWheelDown, MWheelUp, 1, 2, 3, 4, 5
- Grenades (5): 6, 7, 8, 9, 0
- Communication (6): K, Z, X, C, Y, U
- Buy Menu (3): B, F3, F4
- Interface (3): Tab, M, ` (Console) ⭐ NEW

### Valorant v2.0.0 - Complete Keybinds:
- Movement (7): W, A, S, D, Space, LCtrl, LShift
- Combat (4): LMB, RMB, R, F
- Abilities (4): C, Q, E, X
- Equipment (6): 1, 2, 3, 4, G, Y (Inspect) ⭐ NEW
- Communication (6): U, V, Enter, LShift+Enter, Z, MMB
- Interface (5): B, M, CapsLock, Tab, MMB

**Sources:**
- [CS2 Keybinds Guide (Apex Hosting)](https://apexminecrafthosting.com/cs2-keybinds/)
- [Valorant Best Keybinds (Setup.gg)](https://www.setup.gg/game/valorant/best-keybinds/)

---

## 🔄 **How Users Get Updates**

```
You Push to GitHub
      ↓
Within 5 seconds
      ↓
User's App Checks GitHub (DefaultProfileUpdater)
      ↓
New Version Detected
      ↓
Auto-Download & Install
      ↓
Database Updated
      ↓
Users See New Keybinds! 🎉
```

---

## 📁 **File Sync Rules**

**ALWAYS keep these files in sync:**

1. **Hardcoded** (`src/main/db/defaultProfiles.ts`)
   - Used for: Initial app seed, offline mode
   - Update when: Major changes, new app releases

2. **GitHub JSON** (`keybindcompanion-default-profiles/profiles/*.json`)
   - Used for: Cloud updates, version control
   - Update when: Any keybind changes

3. **Manifest** (`keybindcompanion-default-profiles/manifest.json`)
   - Used for: Version tracking
   - Update when: Version numbers change

---

## ⚡ **Quick Reference**

### Dry Run (Test Without Publishing)
```powershell
.\publish-profiles.ps1 -DryRun
```

### Check What Changed
```powershell
git status
git diff
```

### View Commit History
```powershell
git log --oneline
```

### Undo Last Commit (If Not Pushed)
```powershell
git reset --soft HEAD~1
```

---

## 🎓 **Best Practices**

1. ✅ **Always sync versions** - Keep hardcoded and GitHub identical
2. ✅ **Test locally first** - Run app to verify keybinds work
3. ✅ **Use semantic versioning** - 2.0.0 → 2.1.0 for new features
4. ✅ **Write clear messages** - "Update CS2 v2.1.0: Add voice chat"
5. ✅ **Update manifest dates** - Use current ISO 8601 timestamp

---

## 🐛 **Troubleshooting**

### "Authentication failed"
**Solution:** Run `gh auth login` or set up SSH key

### "Nothing to commit"
**Solution:** No changes detected. Edit files first!

### "Permission denied"
**Solution:** Verify you have write access to the repository

### Script won't run
**Solution:** Right-click `publish-profiles.ps1` → "Run with PowerShell"

---

## 🎉 **You're All Set!**

Your workflow is now:
1. Edit profiles
2. Run `.\publish-profiles.ps1`
3. Done!

**No cloning, no separate folders, no web interface!** 🚀
