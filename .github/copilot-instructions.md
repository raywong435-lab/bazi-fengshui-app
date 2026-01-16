# Bazi Fengshui App - AI Coding Agent Instructions

## Project Overview
Flutter + Firebase monorepo for Chinese astrology (Bazi/八字) report generation using Gemini AI. The app allows users to input birth data, generates Bazi charts via Cloud Functions, and creates personalized astrological reports.

## Quick Links
- **Full Architecture**: [ARCHITECTURE.md](../ARCHITECTURE.md)
- **Development Setup**: [DEVELOPMENT_SETUP.md](../DEVELOPMENT_SETUP.md)
- **Fixes Applied**: [FIXES_SUMMARY.md](../FIXES_SUMMARY.md)

## Architecture

### Monorepo Structure (Melos)

**Active Structure:**
```
bazi_fengshui_app/
├── apps/
│   ├── flutter_app/              # Main Flutter application
│   │   ├── lib/
│   │   │   ├── features/         # Feature-first architecture
│   │   │   │   ├── auth/
│   │   │   │   ├── charts/
│   │   │   │   └── reports/
│   │   │   ├── shared/           # Shared widgets and models
│   │   │   └── main.dart
│   │   ├── integration_test/
│   │   └── pubspec.yaml
│   └── firebase_functions/       # Cloud Functions
│       ├── src/
│       │   ├── index.ts          # Entry point
│       │   ├── callable/         # Callable functions (createChart, generateReport)
│       │   ├── services/         # External services (gemini.ts)
│       │   ├── types/            # TypeScript types & Zod schemas
│       │   └── tasks/            # Scheduled functions
│       └── package.json
└── packages/
    ├── core/                     # Shared Dart models (Freezed)
    └── shared_types/             # Cross-platform type definitions
```

**Legacy (Deprecated):**
- `app/` - Old Flutter app location
- `firebase/functions/` - Old Functions location
- `/flutter_app/` - Root-level duplicate
- `/functions/` - Root-level duplicate

**Critical:** Use `melos` for all workspace operations. Run `melos bootstrap` after dependency changes.

### Flutter App (Clean Architecture + Feature-First)

**Current Structure:** `apps/flutter_app/lib/features/{feature}/{layer}/`
- `application/` - Riverpod providers & business logic
- `data/` - Repositories & data sources
- `presentation/` - UI (pages, widgets, view-specific providers)
- `domain/` - Entities (if needed)

Example: [apps/flutter_app/lib/features/charts/application/chart_form_provider.dart](bazi_fengshui_app/apps/flutter_app/lib/features/charts/application/chart_form_provider.dart)

### Firebase Functions

**Current Structure:**
- Entry point: [apps/firebase_functions/src/index.ts](bazi_fengshui_app/apps/firebase_functions/src/index.ts)
- Callable functions: `src/callable/*.ts` ([createChart.ts](bazi_fengshui_app/apps/firebase_functions/src/callable/createChart.ts), [generateReport.ts](bazi_fengshui_app/apps/firebase_functions/src/callable/generateReport.ts))
- Scheduled tasks: `src/tasks/*.ts` (resetMonthlyQuota)
- Services: `src/services/` ([gemini.ts](bazi_fengshui_app/apps/firebase_functions/src/services/gemini.ts), quota.ts, cache.ts)
- Types: `src/types/` (errors.ts, zodSchemas.ts, reportSchemas.ts)
- Compile TypeScript → `lib/` before deployment

## Key Technologies & Patterns

### Flutter
- **State Management:** Riverpod with code generation (`@riverpod`, `riverpod_annotation`)
- **Immutable Models:** Freezed (`@freezed`) + JSON serialization
- **Code Generation:** Run `flutter pub run build_runner build --delete-conflicting-outputs` after model changes
- **Firebase SDK:** Emulators auto-connect in debug mode (see `main.dart`)

### TypeScript Functions
- **Validation:** Zod schemas for all callable function inputs (`src/types/zodSchemas.ts`)
- **Error Handling:** Custom errors in `src/types/errors.ts` (GeminiApiError, ValidationError)
- **AI Integration:** `src/services/gemini.ts` - Gemini Pro with JSON response validation
- **Bazi Calculation:** `lunar-typescript` library (see `createChart.ts`)

## Development Workflow

### Initial Setup
```bash
cd bazi_fengshui_app
# Note: melos requires Flutter/Dart SDK
# Install dependencies manually for now:
cd apps/flutter_app && flutter pub get
cd ../firebase_functions && npm install
cd ../../packages/shared_types && flutter pub get
cd ../../packages/core && flutter pub get
```

### Flutter Development
```bash
cd bazi_fengshui_app/apps/flutter_app
flutter test                     # Run tests
flutter run                      # Launch app with emulators
```

### Functions Development
```bash
cd bazi_fengshui_app/apps/firebase_functions
npm run build                    # TypeScript → lib/
firebase emulators:start         # Start emulators (ports in firebase.json)
```

### Code Generation
After modifying `@freezed` or `@riverpod` classes:
```bash
cd apps/flutter_app
flutter pub run build_runner build --delete-conflicting-outputs
```

## Firebase Configuration

### Emulator Ports (firebase.json)
- Auth: 9099
- Functions: 5001
- Firestore: 8080
- UI: 4000

**Important:** App auto-connects to emulators in debug mode (main.dart:20-28). Android uses `10.0.2.2` instead of `localhost`.

### Firestore Security Rules
- Users: read/write own data only (`users/{userId}`)
- Cache: authenticated users only (`cache/{cacheId}`)

### Deployment
```bash
melos run deploy:functions   # Deploy to asia-east1 region
```

## Project-Specific Conventions

### Import Paths (Flutter)
- Absolute package imports: `package:bazi_fengshui_app/features/...`
- Cross-feature imports via `shared/` or `core` package only

### Riverpod Providers
- Use code generation (`@riverpod`) over manual provider declarations
- Keep providers near usage: application-layer providers in `application/`, view-specific in `presentation/providers/`
- Use `keepAlive: true` for global state: `@Riverpod(keepAlive: true)`

### Freezed Models
- All API responses and domain models use Freezed
- Always include `fromJson`/`toJson` factories
- Run build_runner after changes

### TypeScript Functions
- Export all functions from `src/index.ts` ONLY
- Single responsibility: one file per function
- Use `functions.region("asia-east1")` for all callables
- Validate inputs with Zod before processing

### Gemini AI Usage
- Prompt structure in `src/services/gemini.ts`
- Always validate JSON responses with Zod schemas
- Handle `GeminiApiError` and `JsonParsingError` separately

## Critical Files
- [bazi_fengshui_app/melos.yaml](bazi_fengshui_app/melos.yaml) - Workspace scripts
- [bazi_fengshui_app/app/lib/main.dart](bazi_fengshui_app/app/lib/main.dart) - Emulator setup
- [firebase.json](firebase.json) - Firebase config & emulator ports
- [bazi_fengshui_app/firebase/functions/src/index.ts](bazi_fengshui_app/firebase/functions/src/index.ts) - Functions entry point
- [bazi_fengshui_app/firebase/functions/src/services/gemini.ts](bazi_fengshui_app/firebase/functions/src/services/gemini.ts) - AI service

## Common Pitfalls
- **Forgetting code generation:** Changes to `@freezed`/`@riverpod` require running build_runner
- **Emulator connection:** Android requires `10.0.2.2`, not `localhost`
- **Melos scope:** Use `--scope` flag to target specific packages
- **Functions deployment:** Must run `npm run build` before deploying (compiles TS)
- **API Key:** Set Gemini key via `firebase functions:config:set gemini.key="..."` or `.env.local`