# 🎓 SkillSwap

### Teach what you know. Learn what you love.

**Student-to-Student Skill Exchange | Flutter & Dart | Mobile-First UI**

> A campus-focused educational prototype that helps students discover peers with complementary interests, explore transparent matching scores and try the flow of requesting a skill exchange.

**Status:** Offline demo MVP  ·  **Language:** Dart  ·  **Framework:** Flutter  ·  **License:** MIT

---

## ✨ Highlights

| Feature | What it does |
| --- | --- |
| 🔎 Discover students | Browse five sample student profiles and search skills |
| 🧠 Skill matching | Rank profiles with a transparent, deterministic match score |
| 🔁 Exchange requests | Create demo requests and simulate acceptance |
| 💬 Chat prototype | Explore an in-memory conversation interface |
| ✍️ Editable skills | Update the local learner's teaching and learning interests |
| 📱 Material 3 UI | Dark, mobile-friendly interface with three main tabs |
| 🧪 Unit tests | Verify the skill-matching logic |

## 🧰 Tech stack

`Dart` · `Flutter` · `Material 3` · `Local State` · `Unit Testing` · `GitHub Actions`

**Important:** Firebase, real user accounts and a network backend are **not** included in this MVP.

## 🚀 Getting started

**Prerequisites:** Flutter SDK (includes Dart), Chrome or a configured Android emulator.

```bash
flutter doctor
git clone https://github.com/YOUR_USERNAME/skillswap-flutter.git
cd skillswap-flutter
```

This repository intentionally contains the hand-written Flutter source but not the generated Android/web platform folders. Generate them once, then fetch dependencies:

```bash
flutter create --project-name skillswap --platforms=android,web .
flutter pub get
flutter run -d chrome
```

For Android:

```bash
flutter devices
flutter run
```

No Firebase credentials or API keys are required.

## 📱 Explore the app

**Discover** — Search by skills, review fictional profiles and check match percentages.

**Exchanges** — Send demonstration requests and simulate the next steps of the workflow.

**My skills** — Update what you can teach and what you want to learn.

**Demo chat** — Experiment with the chat interface. No message is transmitted to another person.

## 🧮 Matching algorithm

The deterministic score uses mutual learning and teaching compatibility:

| Component | Maximum points |
| --- | ---: |
| Skills you want that the peer can teach | 40 |
| Skills you can teach that the peer wants | 40 |
| Bonus if both directions match | 20 |
| **Total** | **100** |

This is a **rule-based heuristic** rather than AI/ML. It is intended to be readable, testable and easy to improve.

## 📁 Project structure

```text
skillswap-flutter/
├── lib/
│   ├── main.dart                     # Screens and navigation
│   ├── logic/skill_match.dart        # Matching algorithm
│   ├── models/student.dart           # Profile model
│   └── state/skill_store.dart        # Demo data and app state
├── test/skill_match_test.dart         # Unit tests
├── pubspec.yaml
├── analysis_options.yaml
├── .github/workflows/ci.yml
└── LICENSE
```

## ✅ Test and analyze

```bash
flutter analyze
flutter test
```

GitHub Actions is configured to generate the necessary Flutter platforms, run static analysis and execute tests. **Note:** The original project was not built locally in its generation environment because Flutter was unavailable. Verify on your own Flutter setup before publishing release builds.

## 🗺️ Roadmap (not implemented yet)

- [ ] Persist preferences and requests across restarts
- [ ] User sign-in with Firebase Authentication
- [ ] Firestore profiles and real-time messaging
- [ ] Session scheduling, ratings and notifications
- [ ] Moderation, privacy controls and account deletion

## 🔒 Current limitations

The five student profiles are **fictional demo data**. Requests, chats and profile changes remain in app memory and are reset when the app restarts. There is **no backend, real-time chat, cloud database, authentication or actual peer connection** yet. Do not present this prototype as a live social platform.

## 📸 Screenshots

After running the app, add real screenshots of Discover, Exchanges and My Skills. Avoid mockups that imply unavailable features are live.

## 🤝 Contributions & license

Ideas and improvements are welcome. MIT licensed — see [LICENSE](LICENSE).

---

**GitHub description:** A Flutter student skill-exchange app featuring peer discovery, skill matching, exchange requests, and demo chat.
