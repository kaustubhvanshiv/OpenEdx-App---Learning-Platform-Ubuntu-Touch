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
1. Overview
Clickable is a tool to help build, package, and deploy Ubuntu Touch apps from your desktop (or dev machine) to Ubuntu Touch devices. (Clickable)

Prerequisites
A Linux system (Ubuntu is typical) or a VM if you're on Windows/macOS.
An Ubuntu Touch device (or emulator) connected with USB or reachable over SSH. Developer mode enabled.
Install ADB if you want to deploy over USB.

*Step-by-step Instructions:*
 Open a terminal, and run:

sudo apt update
sudo apt install docker.io adb git python3 python3-pip python3-setuptools

This installs Docker (needed for building), ADB (for deploying), Git, Python tools, etc. (GitLab)


Install Clickable:
 pip3 install --user clickable-ut

This installs the Clickable Python package. (GitLab)


Add Clickable to your PATH
To run it easily without typing full path, add the user-local bin folder to PATH. For example:

echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.bashrc
source ~/.bashrc

Then verify with:
 clickable --version

*Initial setup*

Optional but recommended:
 clickable setup
This sets up bash completion and Docker permissions etc. (GitLab)


2. Download the zip file of the code.
   
3. Open the terminal and go to the folder using:
   cd ~/openedx.
   
4. Now that we are insdie our openedx folder we have to run a command that allows the local root user to connect to your X server so root can open GUI applications on your display.
   xhost +local:root
   
5. Now to run the app you have to type command:
   clickable desktop

6. Now you can see the app interface!! Hurray!!

🧩 Technical Decisions

- Why JavaScript for API calls?
QML integrates smoothly with JavaScript, allowing direct interaction with REST APIs without requiring Python bindings.
- Why QQC2/Kirigami?
Both toolkits provide responsive, native-style UI components suitable for Lomiri and Ubuntu Touch.

🌍 Why This Matters
This app bridges the gap between open education and open-source mobile platforms, giving Ubuntu Touch/Lomiri users the power to learn anytime, anywhere. It extends Open edX’s mission of democratizing education while showcasing how open-source tools can empower both developers and learners.

👥 Contributors
- [Kaustubh Vanshiv] – Developer
- [Jay Dhakad] - Developer
- [Zuzahain Inamdar] - Developer
- [Kanchana Gaira] - Developer

Open Source Community

**Project Guide: 
Dr. Prof. Ishwari Raskar**

*Project Folder Structure:*

- assets/ # Logos and images
- build/ # Auto-generated build files (ignored in repo)
- po/ # Localization files
- qml/ # UI components and logic
  
- |--- components/ # Reusable QML components (CourseCard, CourseList, etc.)
- |--- js/ # API, authentication, and storage scripts
- |--- LoginPage.qml # Login screen
- |--- Main.qml # App entry point
-  clickable.yaml # Clickable config (Ubuntu Touch build)
- MakeLists.txt # Build configuration
- manifest.json.in # Manifest template
- openedx.desktop.in # Desktop entry
- openedx.apparmor # Security/AppArmor profile
- LICENSE # License file
- README.md # Project documentation
