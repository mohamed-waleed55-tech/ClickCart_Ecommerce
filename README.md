# 🛒 ClickCart – AI-Powered Offline-First E-Commerce Platform

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase"/>
  <img src="https://img.shields.io/badge/GetX-7B1FA2?style=for-the-badge&logo=flutter&logoColor=white" alt="GetX"/>
  <img src="https://img.shields.io/badge/Gemini_AI-121212?style=for-the-badge&logo=google-gemini&logoColor=white" alt="Gemini"/>
  <img src="https://img.shields.io/badge/DummyJSON_API-1E88E5?style=for-the-badge" alt="DummyJSON"/>
</p>

---

# 📱 Overview

**ClickCart** is a modern AI-powered Flutter e-commerce application designed with a scalable architecture and an **Offline-First** approach. The application combines Firebase services, local storage, REST APIs, and Google's Gemini AI to deliver a fast, intelligent, and seamless shopping experience.

Built using **Clean Architecture principles**, the **Repository Pattern**, and **GetX**, ClickCart provides maintainable code, efficient state management, and a responsive user interface.

---

# 🎥 App Demo

A complete walkthrough showcasing:

- User Authentication
- Home Screen
- Product Categories
- Best Sellers
- Product Details
- Smart Search
- AI Shopping Assistant
- Favorites
- Shopping Cart
- Checkout Process
- User Profile
- Offline Mode
- Firebase Synchronization

---

# 📐 System Design & Architecture

The project follows a layered architecture that separates presentation, business logic, and data sources for better scalability and maintainability.

## 🖥 Presentation Layer

- Flutter Widgets
- GetX Controllers
- Reactive UI
- Responsive Design

## ⚙ Business Layer

- Repository Pattern
- Dependency Injection
- Business Logic Isolation
- Reusable Components

## 💾 Data Layer

- Firebase Authentication
- Cloud Firestore
- DummyJSON REST API
- Google Gemini API
- Sqflite Local Database

This architecture enables:

- Clean Code
- Easy Testing
- Separation of Concerns
- Offline Support
- Scalability
- Maintainability

---

# ✨ Features

## 🤖 AI Shopping Assistant

Powered by **Google Gemini API**, the AI assistant understands natural language and helps users find products quickly.

Example:

> "I need a laptop under \$1000"

The assistant automatically:

- Detects user intent
- Extracts product category
- Understands budget
- Generates search keywords
- Returns friendly responses
- Finds matching products

---

## 🛍 Product Catalog

Products are dynamically fetched from the **DummyJSON REST API**.

Features include:

- Browse Products
- Product Categories
- Featured Products
- Best Sellers
- Product Details
- Product Images
- Product Ratings
- Discounts
- Brand Information

---

## 🔍 Smart Search

Search products instantly by:

- Product Name
- Category
- AI-powered Intent Recognition
- Keyword Matching

---

## ❤️ Favorites

Users can:

- Add products to Favorites
- Remove Favorites
- View Saved Products
- Persist favorites locally

---

## 🛒 Shopping Cart

Complete shopping cart functionality:

- Add Products
- Remove Products
- Increase Quantity
- Decrease Quantity
- Live Price Calculation
- Persistent Cart Storage
- Offline Cart Support

---

## 💳 Checkout

Simple checkout workflow including:

- Order Summary
- Shipping Details
- Total Price Calculation
- Order Confirmation

---

## 👤 User Profile

Profile management features include:

- Firebase Authentication
- Google Sign-In
- User Information
- Profile Customization
- Logout

---

## ☁ Firebase Integration

Firebase powers:

- User Authentication
- Cloud Firestore
- Analytics
- Crash Reporting

---

## 📶 Offline-First Experience

ClickCart continues working even without an internet connection.

Offline capabilities include:

- Cached Products
- Shopping Cart
- Favorites
- User Preferences

The application automatically synchronizes local and cloud data once the connection is restored.

---

## 🔄 Real-Time Synchronization

Cloud Firestore keeps user data synchronized across devices.

Synced data includes:

- User Profile
- Favorites
- Shopping Cart
- Orders

---

# 🌐 Data Sources

The application integrates multiple data providers.

## DummyJSON REST API

Used for:

- Products
- Categories
- Images
- Prices
- Ratings
- Product Details

---

## Firebase

Provides:

- Authentication
- Cloud Firestore
- Analytics
- Crashlytics

---

## Google Gemini API

Used as an intelligent shopping assistant that:

- Understands user intent
- Extracts shopping parameters
- Generates natural-language responses
- Improves search experience

---

## Sqflite

Local database responsible for:

- Offline Product Cache
- Shopping Cart
- Favorites
- Persistent Storage

---

# 🛠 Tech Stack

## Mobile Development

- Flutter
- Dart

## State Management

- GetX

## Backend

- Firebase Authentication
- Cloud Firestore

## Local Storage

- Sqflite
- GetStorage

## Networking

- Dio
- Retrofit
- REST API Integration
- DummyJSON API

## Artificial Intelligence

- Google Gemini API

## Firebase Services

- Firebase Authentication
- Cloud Firestore
- Firebase Analytics
- Firebase Crashlytics

## Additional Packages

- Flutter ScreenUtil
- Flutter SVG
- Connectivity Plus
- Freezed
- Json Serializable
- Equatable

  ---
  # 🔒 Security

ClickCart incorporates several security practices to improve application reliability and reduce common security risks.

### 🔐 API Key Management

- Sensitive configuration values are stored in a `.env` file using `flutter_dotenv`.
- API keys are never hardcoded directly in the application source code.
- Environment variables are loaded securely during application startup.

> **Note:** Since Flutter applications run on client devices, `.env` values are bundled into the app and should not be considered completely secure. For production environments, sensitive API calls should be proxied through a secure backend or Firebase Cloud Functions.

---

### 🛡 Code Obfuscation

The application is prepared for release builds using Flutter's code obfuscation to make reverse engineering more difficult.

Example release command:

```bash
flutter build apk --release --obfuscate --split-debug-info=build/debug-info
```

Benefits:

- Makes Dart symbols unreadable
- Increases resistance against reverse engineering
- Protects business logic from static analysis

---

### 🚫 Reverse Engineering Protection

Security measures include:

- Dart code obfuscation
- Environment variable separation
- No hardcoded secrets in source code
- Secure Firebase configuration
- Release build optimizations

---

### 🚨 Error Handling

The application includes centralized error handling to improve stability.

Features include:

- Global exception handling
- Network request error handling
- API timeout handling
- Friendly user error messages
- Graceful fallback for offline mode

Firebase Crashlytics is integrated to collect crash reports and runtime exceptions for monitoring and debugging.

---

### 🔓 Jailbreak & Root Detection

To help protect sensitive functionality, the application performs device integrity checks.

Security checks include:

- Android Root Detection
- iOS Jailbreak Detection
- Emulator detection (where applicable)
- Detection of potentially unsafe environments

These checks help reduce the risk of running the application on compromised devices.

---

### 🌐 Secure Networking

Network communication follows secure practices:

- HTTPS-only API communication
- Secure Firebase SDK connections
- Request timeout configuration
- Network connectivity monitoring
- Safe API response validation

---

### 🔑 Authentication Security

Authentication is powered by Firebase Authentication.

Security features include:

- Secure Firebase Authentication
- Google Sign-In
- Protected user sessions
- Secure authentication tokens

---

### 📱 Offline Data Protection

Local application data is managed responsibly by:

- Sqflite local database
- Persistent storage with GetStorage
- Cached product data
- Offline cart and favorites management

Sensitive credentials are **not** stored inside the local database.

---

### ✅ Security Highlights

- Environment Variables (.env)
- API Key Isolation
- Flutter Code Obfuscation
- Reverse Engineering Protection
- Firebase Authentication
- Firebase Crashlytics
- Centralized Error Handling
- Network Timeout Handling
- Jailbreak & Root Detection
- HTTPS Communication
- Offline Data Protection

---

# 📂 Project Structure

```
lib/
│
├── core/
│   ├── assets/
│   ├── constants/
│   ├── database/
│   ├── networking/
│   ├── services/
│   ├── utils/
│   └── widgets/
│
├── features/
│   ├── auth/
│   ├── home/
│   ├── products/
│   ├── categories/
│   ├── cart/
│   ├── checkout/
│   ├── favorites/
│   ├── profile/
│   ├── search/
│   ├── ai_assistant/
│   └── onboarding/
│
└── main.dart
```

---

# 🚀 Highlights

- ✅ Clean Architecture
- ✅ Repository Pattern
- ✅ Offline-First Design
- ✅ GetX State Management
- ✅ Responsive UI
- ✅ Firebase Authentication
- ✅ Cloud Firestore
- ✅ DummyJSON REST API Integration
- ✅ Google Gemini AI Integration
- ✅ AI Shopping Assistant
- ✅ Product Search
- ✅ Product Categories
- ✅ Best Sellers
- ✅ Favorites System
- ✅ Shopping Cart
- ✅ Checkout Workflow
- ✅ User Profile Management
- ✅ Local Database (Sqflite)
- ✅ Crash Reporting
- ✅ Analytics
- ✅ Reusable Widgets
- ✅ Scalable Codebase

---

# 📈 Future Improvements

- Payment Gateway Integration
- Push Notifications
- Product Reviews
- Wishlist Synchronization
- Order History
- Admin Dashboard
- Multi-language Support
- Dark Mode
- Product Recommendations
- Voice Shopping Assistant

---

# 👨‍💻 Author

## Mohamed Waleed

**Junior Flutter & Android Developer**

Passionate about building scalable mobile applications with clean architecture, Firebase services, REST APIs, and AI-powered user experiences.

### Technical Skills

- Flutter
- Dart
- Android Development
- Firebase
- Cloud Firestore
- REST APIs
- GetX
- Clean Architecture
- Repository Pattern
- SQLite (Sqflite)
- Dio
- Retrofit
- Google Gemini API
- Git & GitHub

---

## ⭐ Support

If you found this project helpful, consider giving it a ⭐ on GitHub. Your support is greatly appreciated!
