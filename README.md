# Open edX on the Go: A Mobile Learning App for Ubuntu Touch/Lomiri  

Our project bring the **Open edX learning platform** to **Ubuntu Touch (Clickable)** and **Lomiri (Snap)**.  
The app enables users to **browse, enroll in, and complete Open edX courses** with features like **video lectures, quizzes, progress tracking, and offline support** — all optimized for the privacy-focused Ubuntu Touch ecosystem.  

---

# 🚀 Objective  
Build a mobile app that provides a seamless learning experience on Ubuntu Touch/Lomiri, while respecting technical constraints and leveraging QML/JavaScript (frontend) and Python (optional backend).  

---

## 📖 Background  
- **Open edX**: A widely used open-source LMS offering online courses, video lectures, quizzes, and discussions.  
- **Ubuntu Touch & Lomiri**: Privacy-first mobile OS platforms, but currently lack a dedicated Open edX client.  
- **Goal**: Create a functional, user-friendly app that integrates with the Open edX REST API for real-world learning on mobile devices.  

---

## ✨ Features  
- **Course Browsing**: Discover courses by category, popularity, or keyword search.  
- **Enrollment**: Enroll in Open edX courses and manage your list.  
- **Content Viewing**: Access video lectures, text-based materials, and quizzes.  
- **Offline Support**: Download videos/materials for offline use.  
- **User Authentication**: Secure login with Open edX credentials.  
- **Progress Sync**: Automatically sync progress with the Open edX server.  

**Bonus (Optional):**  
- Push notifications for course updates.  
- Dark mode for readability.  
- Support multiple Open edX instances (e.g., self-hosted servers).  

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
- Test instance of Open edX (https://courses.edx.org/)).  

### Steps  
1. Clone this repository:  
   ```bash
   git clone https://github.com/kaustubhvanshiv/OpenEdx-App---Learning-Platform-Ubuntu-Touch-
   cd openedx-on-the-go

2. Build and install for Ubuntu Touch:
   clickable

3. Launch the app from your device/emulator.

🧩 Technical Decisions

- Why JavaScript for API calls?
QML integrates smoothly with JavaScript, allowing direct interaction with REST APIs without requiring Python bindings.
- Why QQC2/Kirigami?
Both toolkits provide responsive, native-style UI components suitable for Lomiri and Ubuntu Touch.

🌍 Why This Matters
This app bridges the gap between open education and open-source mobile platforms, giving Ubuntu Touch/Lomiri users the power to learn anytime, anywhere. It extends Open edX’s mission of democratizing education while showcasing how open-source tools can empower both developers and learners.

👥 Contributors
[Kaustubh Vanshiv] – Developer
[Jay Dhakad] - Developer
[Zuzahain Inamdar] - Developer
[Kanchana Gaira] - Developer
Open Source Community

**Project Guide: 
Dr. Prof. Ishwari Raskar**

*Project Folder Structure:*

├── assets/ # Logos and images
├── build/ # Auto-generated build files (ignored in repo)
├── po/ # Localization files
├── qml/ # UI components and logic
│ ├── components/ # Reusable QML components (CourseCard, CourseList, etc.)
│ ├── js/ # API, authentication, and storage scripts
│ ├── LoginPage.qml # Login screen
│ └── Main.qml # App entry point
├── clickable.yaml # Clickable config (Ubuntu Touch build)
├── CMakeLists.txt # Build configuration
├── manifest.json.in # Manifest template
├── openedx.desktop.in # Desktop entry
├── openedx.apparmor # Security/AppArmor profile
├── LICENSE # License file
└── README.md # Project documentation
