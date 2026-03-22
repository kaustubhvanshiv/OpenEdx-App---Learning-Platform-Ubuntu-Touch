# 🚀 OpenEdx Ubuntu Touch App – Developer Guide

## 🧠 Overview
This project is a QML + JavaScript based Ubuntu Touch app built using Clickable.  
It currently has a working UI but partial backend integration.

---

# ⚙️ 1. Setup Instructions

## 📦 Install Dependencies

### Install Docker
```bash
sudo apt install docker.io
sudo usermod -aG docker $USER
newgrp docker
```

Verify:

```bash
docker ps
```

---

### Install pipx

```bash
sudo apt install pipx
pipx ensurepath
source ~/.bashrc
```

---

### Install Clickable (IMPORTANT: use pipx, NOT snap)

```bash
pipx install clickable-ut
```

Verify:

```bash
which clickable
# should be ~/.local/bin/clickable
```

---

# 📁 2. Project Setup

## Clone repo

```bash
git clone <your-repo-url>
cd openedx
```

⚠️ IMPORTANT:
Avoid spaces in folder names.

---

# 🔨 3. Build the Project

If build fails or after moving folders:

```bash
rm -rf build
```

Then:

```bash
clickable build
```

Expected output:

* `.click` package generated
* No CMake errors

---

# ▶️ 4. Run the App

## Run in Desktop Mode (Recommended)

```bash
clickable desktop
```

OR

```bash
clickable run --desktop
```

---

## ❗ If it drops into root shell

You may see:

```bash
root@...
```

👉 This means you're inside Docker container.

Fix:

```bash
exit
```

Then run:

```bash
clickable desktop
```

---

# 🧪 5. Debugging Guide

---

## ❌ Issue: Docker Permission Denied

Error:

```
permission denied /var/run/docker.sock
```

Fix:

```bash
sudo usermod -aG docker $USER
newgrp docker
```

---

## ❌ Issue: Clickable Snap Problems

Symptom:

```
Missing connection(s)
snap connect clickable:docker
```

Fix:

```bash
sudo snap remove clickable
pipx install clickable-ut
```

---

## ❌ Issue: CMake Cache Error

Error:

```
CMakeCache.txt directory is different
```

Fix:

```bash
rm -rf build
clickable build
```

---

## ❌ Issue: App opens but shows errors

Example:

```
TypeError: Property is not a function
```

Cause:

* Incorrect JS module usage
* Wrong object references

Fix:

* Check `api.js`, `storage.js`, `auth.js`
* Ensure correct function calls

---

## ❌ Issue: App UI opens but no real data

Cause:

* Data is hardcoded (demo mode)

Fix:

* Replace:

```js
allCourses()
```

With:

```js
fetch(API_URL)
```

---

# 🧩 6. Project Structure

```
qml/
 ├── Main.qml          # Main UI + navigation
 ├── Loginpage.qml     # Login UI
 ├── components/       # UI components
 └── js/
     ├── api.js        # API calls
     ├── auth.js       # Authentication
     └── storage.js    # Offline/cache logic
```

---

# 🔥 7. Development Workflow

## Step-by-step

1. Make changes in QML or JS
2. Run:

```bash
clickable desktop
```

3. Check logs in terminal
4. Fix errors
5. Repeat

---

# 🧠 8. Best Practices

✅ Always delete `build/` if weird errors
✅ Avoid using Snap for Clickable
✅ Use `console.log()` for debugging
✅ Test small changes frequently

---

# 🚀 9. Next Goals

* [ ] Connect Open edX API
* [ ] Replace fake course data
* [ ] Implement login (token-based)
* [ ] Enable video playback
* [ ] Fix offline sync

---

# 🧠 Final Note

Current state:

* UI: ✅ Complete
* Backend: ❌ Not integrated
* API: ❌ Not connected

Goal:
👉 Convert this from demo → real app

---
