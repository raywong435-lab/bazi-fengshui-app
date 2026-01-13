# Complete Integration Guide - Monorepo Architecture

## 📋 Project Structure Overview

```
bazi_fengshui_app/
├── apps/
│   ├── flutter_app/              ← Main Flutter application
│   │   ├── lib/
│   │   │   ├── features/         ← Feature-first structure
│   │   │   │   ├── auth/
│   │   │   │   ├── charts/
│   │   │   │   └── reports/
│   │   │   ├── shared/
│   │   │   └── main.dart
│   │   └── pubspec.yaml
│   └── firebase_functions/       ← TypeScript Cloud Functions
│       ├── src/
│       │   ├── index.ts          ← Entry point (exports only)
│       │   ├── callable/         ← Callable functions
│       │   │   ├── createChart.ts
│       │   │   └── generateReport.ts
│       │   ├── services/         ← External integrations
│       │   │   ├── gemini.ts     ← Gemini AI with safe templates
│       │   │   ├── cache.ts
│       │   │   └── quota.ts
│       │   ├── types/            ← TypeScript types & Zod schemas
│       │   │   ├── errors.ts
│       │   │   ├── zodSchemas.ts
│       │   │   └── reportSchemas.ts
│       │   └── tasks/            ← Scheduled functions
│       │       └── resetMonthlyQuota.ts
│       ├── package.json
│       ├── tsconfig.json
│       └── .env.local            ← Local environment variables
├── packages/
│   ├── core/                     ← Shared Dart models
│   │   └── pubspec.yaml
│   ├── shared_logic/             ← Common business logic
│   │   └── pubspec.yaml
│   └── shared_types/             ← Cross-platform types
│       └── pubspec.yaml
├── melos.yaml                    ← Monorepo workspace config
└── firebase.json                 ← Firebase emulator & deployment config
```

## 🚀 Development Workflow

### 1. Initial Setup

```bash
# From repo root
cd bazi_fengshui_app

# Install Dart dependencies (if using melos)
dart pub global activate melos
melos bootstrap

# Or manually for Functions only:
cd apps/firebase_functions
npm ci
```

### 2. Local Development Cycle

```bash
# Terminal 1: Start Firebase Emulator
cd apps/firebase_functions
npm run build
firebase emulators:start --only auth,firestore,functions --debug

# Terminal 2: Run Flutter App (auto-connects to emulator)
cd apps/flutter_app
flutter run

# Terminal 3: Test Functions
cd apps/firebase_functions
npm run shell
# Then: createChart({ name: "Test", birthDate: "2000-01-15", ... })
```

### 3. Code Changes

#### Modifying Flutter Code
```bash
cd apps/flutter_app
# Edit lib/ files
flutter pub run build_runner build --delete-conflicting-outputs  # If models change
flutter run
```

#### Modifying Functions Code
```bash
cd apps/firebase_functions
# Edit src/ files
npm run build:watch  # Auto-compile on save
# Functions automatically reload in emulator
```

### 4. Building for Production

```bash
# Firebase Functions
cd apps/firebase_functions
npm run build
firebase deploy --only functions

# Flutter App
cd apps/flutter_app
flutter build android  # or ios, web, etc.
```

## 🔑 API Keys & Configuration

### Local Development (Emulator)

**For Gemini API Key:**

```bash
# Option A: Create .env.local file
cd apps/firebase_functions
echo "GEMINI_API_KEY=sk-your-key-here" > .env.local

# Option B: Load via Firebase CLI
firebase functions:config:set gemini.key="sk-your-key-here"
firebase functions:config:get > .runtimeconfig.json
```

**In code (gemini.ts):**
```typescript
const functionsConfigKey = functions.config().gemini?.key;
const API_KEY = functionsConfigKey || process.env.GEMINI_API_KEY || '';
```

### Production Deployment

```bash
# Set production API key
firebase functions:config:set gemini.key="sk-your-prod-key" --project=your-project-id

# Deploy
firebase deploy --only functions --project=your-project-id
```

## 🛠 Build & Compilation

### Flutter App
- **Build Tool**: Flutter CLI + build_runner
- **Build Command**: `flutter pub run build_runner build --delete-conflicting-outputs`
- **Why**: Freezed + Riverpod code generation
- **Run**: `flutter run`

### Firebase Functions
- **Build Tool**: TypeScript (tsc)
- **Build Command**: `npm run build` (runs `tsc`)
- **Output**: Compiled JavaScript in `lib/` directory
- **Watch Mode**: `npm run build:watch`

## 📦 Dependencies

### Flutter Dependencies
- **firebase_core**, **firebase_auth**, **cloud_firestore**: Firebase SDKs
- **flutter_riverpod**: State management
- **freezed**: Immutable models
- **timezone**: Time zone handling

### Functions Dependencies
- **firebase-functions** (v5.x): Cloud Functions SDK
- **firebase-admin** (v12.x): Admin SDK
- **@google/generative-ai**: Gemini API client
- **zod**: Schema validation
- **lunar-typescript**: Bazi calculations

**Note**: We removed `zod-to-json-schema` because it causes deep type recursion errors. Use manual schema definitions instead.

## ⚠️ Known Issues & Solutions

### Issue 1: Firebase Emulator Won't Start
**Error**: `No emulators to start`

**Solution**:
```bash
# Verify firebase.json exists at repo root
cat firebase.json
# Should contain "emulators" section with auth, firestore, functions

# Try explicit path
firebase emulators:start --only auth,firestore,functions --config firebase.json
```

### Issue 2: Port Already in Use
**Error**: `Error: Port already in use`

**Solution** (Windows PowerShell as Admin):
```powershell
# Find process using port
netstat -ano | findstr :5001
# Kill it
taskkill /PID 12345 /F
```

### Issue 3: Template Literal Compilation Errors
**Error**: `TypeScript error with triple-backticks in string`

**Solution**: Use array.join() pattern:
```typescript
// ❌ Wrong (causes compiler issues)
const prompt = `
  Some text
  \`\`\`json
  { schema }
  \`\`\`
`;

// ✅ Right (safe)
const prompt = [
  'Some text',
  '```json',
  '{ schema }',
  '```'
].join('\n');
```

### Issue 4: zod-to-json-schema Errors
**Error**: `Type instantiation is excessively deep`

**Solution**: Removed from dependencies. Use `buildBaziReportPrompt()` helper:
```typescript
// Use the safe prompt builder
const prompt = buildBaziReportPrompt(birthData, chartData);
// Returns properly formatted prompt with safe code fences
```

## 🧪 Testing

### Unit Tests

```bash
# Flutter
cd apps/flutter_app
flutter test

# Functions
cd apps/firebase_functions
npm run test
```

### Integration Tests

```bash
# Flutter (requires running emulator)
cd apps/flutter_app
flutter test integration_test/

# Functions (via shell)
cd apps/firebase_functions
npm run shell
# Call createChart(), generateReport(), etc.
```

## 📚 Architecture Decisions

### Why Monorepo?
- Single version control for frontend + backend
- Shared types and models (`packages/shared_types/`)
- Unified build & deployment pipeline
- Easier code sharing and refactoring

### Why Feature-First for Flutter?
- Organizes code by business domain, not layer
- Easy to locate and modify related code
- Scalable structure for growing teams

### Why Separate Entry Point for Functions?
- `index.ts` only exports; implementations live in modules
- Prevents accidental duplication
- Easier to understand what functions are available
- Clear separation of concerns

## 🔗 Deployment Pipeline

```
Local Development
    ↓ (firebase emulators:start)
Firebase Emulator Suite
    ↓ (firebase deploy)
Firebase Console
    ↓
Production (asia-east1 region)
```

**Current Region**: Asia East 1 (Asia-Pacific)

**To change**:
```typescript
// In src/callable/*.ts
export const createChart = functions.region("us-central1")...
```

## 📝 Checklist for New Developers

- [ ] Flutter & Dart SDK installed (`flutter --version`)
- [ ] Node 18+ installed (`node -v`)
- [ ] Java installed for Android emulator
- [ ] Firebase CLI installed (`firebase --version`)
- [ ] Repository cloned with `git clone`
- [ ] `.env.local` created in `apps/firebase_functions/` with API keys
- [ ] `npm ci` run in functions directory
- [ ] `npm run build` succeeds
- [ ] `firebase emulators:start` runs without errors
- [ ] Flutter app connects to emulator and loads
- [ ] Test callable function in functions shell

---

**Last Updated**: January 13, 2026  
**Maintainers**: Ray Wong (raywong435)  
**Architecture**: Monorepo (Melos) + Feature-First Flutter + TypeScript Cloud Functions
