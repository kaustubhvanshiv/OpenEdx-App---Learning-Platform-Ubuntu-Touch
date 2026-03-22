# Open edX on the Go: A Mobile Learning App for Ubuntu Touch/Lomiri

![Status](https://img.shields.io/badge/status-in%20development-yellow)
![Platform](https://img.shields.io/badge/platform-Ubuntu%20Touch-blue)
![Tech](https://img.shields.io/badge/tech-QML%20%2B%20JS-green)
![License](https://img.shields.io/badge/license-GPLv3-blue)
![PRs](https://img.shields.io/badge/PRs-required-brightgreen)

> 📱 Native Open edX client for Ubuntu Touch & Lomiri

Our project brings the **Open edX learning platform** to **Ubuntu Touch (Clickable)** and **Lomiri (Snap)**.
The app enables users to **browse, enroll in, and complete Open edX courses** with features like **video lectures, quizzes, progress tracking, and offline support** - all optimized for the privacy-focused Ubuntu Touch ecosystem.

---

## 🎯 Objective
Build a mobile app that provides a seamless learning experience on Ubuntu Touch/Lomiri, while respecting technical constraints and leveraging QML/JavaScript (frontend) and Python (optional backend).

---

## 📖 Background
- **Open edX**: A widely used open-source LMS offering online courses, video lectures, quizzes, and discussions.
- **Ubuntu Touch & Lomiri**: Privacy-first mobile OS platforms, but currently lack a dedicated Open edX client.
- **Goal**: Create a functional, user-friendly app that integrates with the Open edX REST API for real-world learning on mobile devices.

---

## ⚠️ Current Status
> 🚧 This project is actively evolving. Expect breaking changes.

- This project is currently under development.
- UI and navigation are implemented.
- API integration is partially implemented.
- Authentication is not fully connected.
- Course data is currently mocked.
- Video and quiz functionality are not integrated yet.

---

## ✨ Features

### Core Features
- [x] UI & Navigation (StackView, pages)
- [x] Course browsing UI (static data)
- [x] Basic quiz UI
- [x] Profile & settings UI

### Backend & Integration
- [ ] Open edX API integration
- [ ] Real course fetching
- [ ] Enrollment system
- [ ] Progress tracking (server sync)

### Authentication
- [ ] Login with Open edX credentials
- [ ] Token handling & session management

### Learning Features
- [ ] Video playback (streaming)
- [ ] Quiz submission to backend
- [ ] Course content rendering

### Offline Features
- [ ] Local storage (SQLite)
- [ ] Offline course access
- [ ] Sync when back online

### Bonus Features
- [ ] Push notifications
- [ ] Dark mode improvements
- [ ] Multiple Open edX instances

---

## 🛠️ Tech Stack

### Frontend
- **QML/JavaScript**: Core UI development.
- **UI Toolkit**: QQC2 (Qt Quick Controls 2) for a native feel.

### Backend
- **Preferred**: Direct Open edX REST API calls from JavaScript.
- **Fallback**: Python backend (decoupled from QML, e.g., local HTTP server).

### API
- **Open edX REST API**: Fetch course lists, enrollment, content, and user progress.

### Packaging
- **Ubuntu Touch**: Package with [Clickable](https://clickable-ut.dev/en/latest/).
- **Lomiri**: Package as a Snap with [Snapcraft](https://snapcraft.io/).

---

## 📦 Installation

### Prerequisites
- Ubuntu Touch SDK or Lomiri development tools.
- [Clickable](https://clickable-ut.dev/en/latest/) installed for Ubuntu Touch builds.
- Test instance of Open edX (https://courses.edx.org/).

### Setup
1. Install dependencies:

```bash
sudo apt update
sudo apt install docker.io git python3 python3-pip pipx
pipx install clickable-ut
pipx ensurepath
source ~/.bashrc
```

2. Enable Docker permissions:

```bash
sudo usermod -aG docker $USER
newgrp docker
```

3. Clone the repository:

```bash
git clone https://github.com/kaustubhvanshiv/openedx-lomiri-app.git
cd OpenEDX
```

### Build & Run
4. Build the app:

```bash
clickable build
```

5. Run the app:

```bash
clickable desktop
```

### 🔍 Quick Testing (Optional)
Run a single QML file without full build:

```bash
qmlscene qml/Main.qml
```

---

## 🔁 Development Workflow

We follow a **branch + pull request workflow**:

1. Fork the repository.
2. Create a new branch from `main`:

```bash
git checkout -b feature/your-feature
```

3. Make your changes.
4. Commit clearly:

```bash
git commit -m "feat: add course API integration"
```

5. Push your branch:

```bash
git push origin feature/your-feature
```

6. Open a Pull Request to main.

Direct pushes to `main` are restricted. All changes must go through PR review.

---

## 🧪 Debugging Tips
- Use `console.log()` in JavaScript files.
- Check terminal output for QML errors.
- If build fails:

```bash
rm -rf build
```

- If Docker issues:

```bash
docker ps
```

---

## 🧩 Technical Decisions
- **Why JavaScript for API calls?**
  QML integrates smoothly with JavaScript, allowing direct REST API usage.

- **Why QQC2/Kirigami?**
  Provides native, responsive UI for Ubuntu Touch / Lomiri.

## 🌍 Why This Matters
This app bridges the gap between open education and open-source mobile platforms, giving Ubuntu Touch/Lomiri users the power to learn anytime, anywhere. It extends Open edX's mission of democratizing education while showcasing how open-source tools can empower both developers and learners.

## 👥 Contributors
- Kaustubh Vanshiv

## 📜 License
This project is licensed under the GNU GPL v3 License.

## ⚠️ Known Issues
- API integration is incomplete
- Authentication flow is not connected
- Data is currently mocked
- Video playback not implemented yet