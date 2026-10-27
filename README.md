
# 🎓 SkillSwap
### Student Skill Exchange Mobile Application

> Share Knowledge. Exchange Skills. Grow Together.

SkillSwap is a student-focused mobile application developed using **Flutter and Dart**.

The application allows students to discover peers with complementary skills and explore opportunities for collaborative learning.

For example, a student who knows Python can find another student who teaches UI/UX design.

---

## 🌟 Key Features

- 👤 Student profile interface
- 🔎 Search students by skills
- 🧠 Rule-based skill matching
- 🔁 Skill exchange requests
- 💬 Interactive demo chat
- ✏️ Editable learning interests
- 📱 Modern Material 3 interface
- 🌙 Dark-themed mobile design
- 🧪 Unit-tested matching algorithm
- 📦 Offline demonstration data

## 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| Dart | Programming language |
| Flutter | Cross-platform UI framework |
| Material 3 | Interface components |
| Local State | Application state |
| Flutter Test | Unit testing |
| GitHub Actions | Automated checks |

## 📁 Project Structure

```text
skillswap-flutter/
├── lib/
│   ├── main.dart
│   ├── logic/
│   │   └── skill_match.dart
│   ├── models/
│   │   └── student.dart
│   └── state/
│       └── skill_store.dart
├── test/
│   └── skill_match_test.dart
├── pubspec.yaml
├── analysis_options.yaml
├── .github/
│   └── workflows/
│       └── ci.yml
├── LICENSE
└── README.md
```

## ⚙️ Installation

### Requirements

- Flutter SDK
- Dart SDK (included with Flutter)
- VS Code or Android Studio
- Chrome or Android emulator

### Clone Repository

```bash
git clone https://github.com/YOUR_USERNAME/skillswap-flutter.git
cd skillswap-flutter
```

### Generate Platform Files

```bash
flutter create --project-name skillswap --platforms=android,web .
```

### Install Dependencies

```bash
flutter pub get
```

### Run Application

```bash
flutter run -d chrome
```

For Android:

```bash
flutter devices
flutter run
```

## 🧠 Skill Matching Algorithm

The application uses a transparent rule-based matching algorithm.

Matching is based on:

- Skills the current student wants to learn
- Skills another student can teach
- Skills the current student can teach
- Skills another student wants to learn

### Matching Score

| Matching Factor | Maximum Score |
|---|---:|
| Learning compatibility | 40 |
| Teaching compatibility | 40 |
| Mutual skill match bonus | 20 |
| Total | 100 |

The algorithm is deterministic and does not currently use machine learning.

## 📱 Application Screens

### Discover
Browse student profiles and search for specific skills.

### Exchanges
Create demonstration skill exchange requests and simulate acceptance.

### My Skills
Manage teaching and learning interests.

### Demo Chat
Explore a sample chat interface without connecting to real users.

## 🧪 Testing

```bash
flutter analyze
flutter test
```

## 🔮 Future Development

- [ ] Firebase Authentication
- [ ] Cloud Firestore integration
- [ ] Real-time messaging
- [ ] Learning session scheduling
- [ ] Push notifications
- [ ] Student verification
- [ ] Ratings and feedback
- [ ] Persistent user profiles

## ⚠️ Current Limitations

This is an offline demonstration application.

Student profiles are fictional, and exchange requests and chat messages are stored temporarily in memory.

Real user authentication, cloud databases, and real-time communication are planned future features.

## 🤝 Contributing

Contributions and suggestions are welcome.

## 📜 License

Licensed under the MIT License.

---

### ⭐ Support

Star this project if you believe in collaborative learning!

**Built with Flutter | Dart | Mobile Development**
