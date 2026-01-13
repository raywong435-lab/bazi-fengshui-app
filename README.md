# Bazi Fengshui App

A Flutter app for astrology report generation with Firebase backend.

## Project Structure

```
bazi_fengshui_app/
├── 📂 .github/
|   └── 📂 workflows/
|       └── 📄 deploy.yml         # GitHub Actions automated deployment
├── 📂 flutter_app/              # Flutter frontend app
|   ├── lib/
|   |   ├── main.dart
|   |   ├── src/
|   |   |   ├── data/            # Models and services
|   |   |   ├── providers/       # Riverpod providers
|   |   |   ├── screens/         # App screens
|   |   |   └── widgets/         # Reusable UI components
|   ├── pubspec.yaml
|   └── ...
├── 📂 functions/                # Firebase Cloud Functions backend
|   ├── src/
|   |   ├── functions/         # Cloud function implementations
|   |   |   ├── charts.ts
|   |   |   ├── reports.ts
|   |   |   └── index.ts
|   |   ├── services/          # External service clients
|   |   |   └── geminiClient.ts  # Gemini AI client
|   |   ├── types/             # TypeScript type definitions
|   |   |   └── zodSchemas.ts  # Zod schemas
|   |   ├── tests/             # Integration tests
|   |   |   └── integration.test.ts
|   |   └── utils/
|   ├── package.json
|   ├── tsconfig.json
|   └── .env.local             # Local environment variables
├── 📄 .firebaserc
├── 📄 firebase.json
└── 📄 firestore.rules          # Firestore security rules
```

## Setup

### Flutter App

1. `cd flutter_app`
2. `flutter pub get`
3. Configure Firebase: `flutterfire configure`
4. Run: `flutter run`

### Firebase Functions

1. `cd functions`
2. `npm install`
3. `npx tsc`
4. Set API key in `.env.local`
5. Deploy: `firebase deploy --only functions`
