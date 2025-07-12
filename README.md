
# 🌱 SeedSight - Smart Seed Identifier App

**SeedSight** is a mobile application built using Flutter that allows users to identify plant seeds through image recognition, manage seed data, and access personalized features like authentication and theme switching. Powered by Firebase services and a custom AI model hosted via HTTP endpoint, the app offers seamless seed detection from camera or gallery, and presents results with confidence levels.

---

## 📸 Core Features

- 📷 **Seed Identification** using image upload and prediction API
- 📦 **Firebase Integration** for authentication and image storage
- 🧠 **ML-Powered Result** prediction via REST API (`/predict` endpoint)
- 💾 **Seed List Screen** with local image caching & offline access
- 🧑‍💼 **User Authentication** using Firebase Auth (SignIn/SignUp)
- 🌓 **Dark Mode / Light Mode** switching using Provider
- 🧭 **Navigation Drawer** for quick access to profile, login, logout, etc.

---

## 📁 Project Structure

```
smriti2805-seed/
├── pubspec.yaml                  # Project metadata and dependencies
└── lib/
    ├── main.dart                 # Entry point of the app
    ├── home_page.dart            # Tab-based home layout (camera, seeds, profile)
    ├── providers/                # App-level state management (auth, seed)
    ├── screens/                  # UI screens for SignIn, SignUp, Profile, Results
    ├── services/                 # Firebase storage and image upload logic
    ├── style/                    # Reusable button styling
    ├── theme/                    # Theme switching logic and definitions
    └── widgets/                  # App drawer for navigation
```

---

## 🚀 Getting Started

### 📦 Prerequisites

- Flutter SDK `>=3.6.2`
- Firebase project setup
- Google-services configuration (`google-services.json` and `GoogleService-Info.plist`)

### 🔧 Installation

```bash
git clone https://github.com/smriti2805/seed.git
cd seed
flutter pub get
```

### 🧪 Run the App

```bash
flutter run
```

> ⚠ Make sure Firebase is initialized properly in `main.dart` using `DefaultFirebaseOptions.currentPlatform`.

---

## 🔌 Dependencies

From `pubspec.yaml`:

- `firebase_core`, `firebase_auth`, `firebase_storage`
- `http`, `image_picker`, `shared_preferences`
- `provider` for state management
- `flutter_launcher_icons`, `animated_splash_screen`, and others

---

## 🌐 API Usage

- The app sends seed images to an AI model hosted at:
  ```
  https://some.example.com/api
  ```
  if you need to create one machine learning model and api for acutal use of this app or you can use other api that classify the seeds on basis of images.
- The API returns:
  ```json
  {
    "class": "Prunus dulcis",
    "confidence": "98.76"
  }
  ```

---

## 📱 Screens Overview

- **Identification Screen**: Upload image → Result screen with prediction
- **Seeds Screen**: View locally cached list of identified seeds
- **Profile Screen**: Authenticated user details or login/signup screen
- **Result Screen**: Displays uploaded image with prediction and confidence
- **SignIn/SignUp**: Firebase-auth enabled login/signup

---

## 🎨 Theming

Light and dark mode support using Provider. Users can toggle modes from the app bar.

---

## 🧠 Caching Strategy

- Seed data and images are downloaded, saved to local storage, and cached using `SharedPreferences` for fast access and offline mode.

---

## 🛡️ Security Notes

- Firebase auth credentials should be handled securely.
- Prediction API must be HTTPS and authenticated if required.
- User data and tokens should be stored and managed securely.

---

## 👨‍💻 Developed By

**Smriti** & **Kishan**  
Powered by Flutter & Firebase.

---

## 🌟 Show Support

If you find this project helpful, feel free to ⭐ the repo and share your feedback!

---

