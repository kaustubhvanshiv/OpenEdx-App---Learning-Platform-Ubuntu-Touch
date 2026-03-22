# OpenEdX App Implementation Explanation

Last updated: 2026-03-22

## 1. What has been implemented until now

### Project and packaging
- CMake-based project setup exists for Ubuntu Touch style packaging.
- Click packaging files are present: clickable.yaml, manifest template, desktop and apparmor templates.
- QML and assets are installed through CMake install rules.

### Main application shell
- Main app window and theme system are implemented in qml/Main.qml.
- Light/dark mode setting is persisted via Qt.labs.settings.
- StackView based navigation is implemented.
- Bottom navigation bar for Courses, Quizzes, Profile, and Settings is implemented.

### Course browsing UI
- A course list page exists with:
  - Search field
  - Grid view cards
  - Progress bars
  - Click-through to a course details page
- Course detail page shows a list of videos and basic course title header.

### Quiz UI
- Quizzes page exists with a quiz list and Start buttons.
- Quiz page rendering exists and shows question text from provided question data.

### Profile and settings UI
- Profile page UI exists with avatar, username label, and welcome text.
- Settings page UI exists with dark mode toggle, notifications toggle, and clear cache button.

### JS utility modules (present but only partly integrated)
- qml/js/api.js: REST request wrapper and getCourses endpoint function.
- qml/js/auth.js: credential storage and OAuth-style login request skeleton.
- qml/js/storage.js: pending sync queue and course cache helper functions.

### Network/offline helper flow in Main.qml
- Basic connectivity check is implemented using XMLHttpRequest.
- Offline sync loop function exists and attempts to process pending sync items.

## 2. What is currently faked or placeholder

### Authentication is simulated in UI
- Login interactions are simulated with local checks and delayed callbacks.
- Main.qml currently auto-authenticates as Guest on startup.
- Real token exchange from auth.js is not wired into the main login flow.

### Course data is hardcoded
- Course list uses a hardcoded allCourses() array.
- Course images are placeholder rectangles rather than real media.

### Quiz data is sample-only
- Quiz list and questions are hardcoded sample data.
- No backend quiz fetch or submission flow exists.

### Video/course learning flow is placeholder
- Course page explicitly states video playback is unavailable.
- Video list is static sample items.

### Cache and sync behavior is mostly stubbed
- Sync function only logs items and removes them, without real server sync.
- Settings "Clear Cache" button currently only prints to console.

### Component folder is partially scaffolded
- Several component files are empty placeholders:
  - qml/components/CourseList.qml
  - qml/components/CoursePage.qml
  - qml/components/DownloadsPage.qml
  - qml/components/SettingsPage.qml
- qml/components/sectionDelegate.qml is intentionally incomplete with a placeholder comment.

## 3. Current errors and known issues

### IDE-detected errors
- No Problems-panel errors are currently reported by the editor tooling for checked files.

### Functional/runtime issues likely in current state
- qml/Main.qml imports storage/auth/api modules but does not use their exported objects correctly in all places.
  - Example: syncOfflineData() calls Storage.getPendingSyncItems() and Storage.removeSyncItem(), while storage.js defines these under Storage.storageManager.
- Authentication/API modules are present but not properly integrated with the actual app startup/login path.
- qml/components/quizzesComponent.qml and qml/components/QuizResultPage.qml reference IDs/properties like appWindow and stackView that are not locally defined in those files. They may fail unless injected by parent context.
- qml/components/QuizPage.qml pushes to stackView, but stackView is not declared inside that component.

### Documentation/build quality issues
- README.md has an unfinished code block under "Getting started" (markdown formatting is broken).
- CMake i18n glob patterns use qml/.qml and qml/.js, which appears incorrect and may prevent translation source collection.

## 4. What is broken in the whole project (current state)

### Core product flow is broken end-to-end
- Users can open and navigate the app UI, but core LMS flows (real login, real course fetch, real quiz fetch/submit, real video learning) do not work with a live Open edX backend.
- The app currently behaves more like a demo shell than a production client.

### Data and business logic integration is broken/incomplete
- The JS service modules exist, but the main UI flow does not consistently call them.
- Some calls use incorrect object paths (for example Storage methods called directly instead of through storageManager), which can break offline sync behavior at runtime.
- State transitions are not backend-driven (authentication is forced to Guest mode on startup).

### Component architecture is fragmented
- There are two parallel UI structures: large inline components in Main.qml and separate files under qml/components.
- Multiple component files are empty or partially implemented, making the component folder non-functional as a standalone architecture.
- Some standalone components reference IDs (for example appWindow, stackView) that are not defined inside their own scope, so reuse or direct loading can fail.

### Offline and sync reliability is broken by design gaps
- Sync currently removes pending items after logging, without confirmed server acknowledgement.
- Cache-related actions are partly UI-only (for example clear cache button logs text instead of clearing all persisted app state).
- This can cause mismatch between UI expectations and persisted/offline data.

### Build/documentation quality has breakpoints
- README onboarding is broken by an unfinished markdown code block.
- Translation source glob patterns in CMake appear incorrect, which can break i18n extraction quality.
- Repository git metadata assumptions in build scripts may fail in non-tagged or detached environments.

### Risk statement
- In current form, the project is suitable for UI prototyping and design iteration.
- It is not yet reliable for real learners or production deployment without integration, architecture cleanup, and runtime hardening.

## 5. Practical summary

This project has a strong UI prototype and navigation foundation, but many core LMS behaviors are still mocked. The app is currently best described as a functional front-end prototype with partial backend/helper scaffolding, not a fully integrated Open edX client yet.
