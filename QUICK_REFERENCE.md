# Quick Reference Card

## 🎯 Most Common Commands

### Start Development
```bash
# Terminal 1: Firebase Emulator
cd bazi_fengshui_app/apps/firebase_functions
npm run build
firebase emulators:start --only auth,firestore,functions --debug

# Terminal 2: Flutter App (auto-connects to emulator)
cd bazi_fengshui_app/apps/flutter_app
flutter run

# Terminal 3: Test Functions
cd bazi_fengshui_app/apps/firebase_functions
npm run shell
```

### Build for Production
```bash
# Functions
cd bazi_fengshui_app/apps/firebase_functions
npm run build
firebase deploy --only functions --project=your-project

# Flutter
cd bazi_fengshui_app/apps/flutter_app
flutter build apk  # Android
flutter build ios  # iOS
flutter build web  # Web
```

## 📁 Key File Locations

| Path | Purpose |
|------|---------|
| `firebase.json` | Emulator & Functions config |
| `bazi_fengshui_app/melos.yaml` | Monorepo scripts |
| `bazi_fengshui_app/apps/firebase_functions/src/index.ts` | Functions entry point |
| `bazi_fengshui_app/apps/firebase_functions/src/services/gemini.ts` | Gemini AI integration |
| `bazi_fengshui_app/apps/flutter_app/lib/main.dart` | Flutter entry point |

## 🔐 Environment Setup

```bash
# Set Gemini API Key (local emulator)
echo "GEMINI_API_KEY=sk-your-key" > bazi_fengshui_app/apps/firebase_functions/.env.local

# Or via Firebase CLI (for deployed functions)
firebase functions:config:set gemini.key="sk-your-key"
```

## 🐛 Troubleshooting

| Problem | Solution |
|---------|----------|
| Firebase emulator won't start | Check `firebase.json` path. Run: `firebase emulators:start --config firebase.json` |
| Port 5001 already in use | `netstat -ano \| findstr :5001` then `taskkill /PID <PID> /F` (Windows) |
| TypeScript compile errors | Run `npm run clean && npm run build` |
| Flutter can't find emulator | Ensure emulator started, check network settings |
| Zod validation errors | Check Zod schemas in `src/types/zodSchemas.ts` |

## 📊 Architecture Diagram

```
┌─────────────────────────────────────────┐
│         Flutter App                      │
│    (apps/flutter_app/lib)                │
│  - Features (auth, charts, reports)     │
│  - Riverpod state management            │
│  - Freezed models                       │
└──────────────┬──────────────────────────┘
               │ Cloud Functions (callable)
               ↓
┌─────────────────────────────────────────┐
│      Firebase Cloud Functions            │
│  (apps/firebase_functions/src)           │
│  - Callable: createChart, generateReport│
│  - Services: Gemini AI, quota tracking  │
│  - Zod validation & error handling      │
└──────────────┬──────────────────────────┘
               │ Firestore documents
               ↓
┌─────────────────────────────────────────┐
│      Firebase Backend (asia-east1)       │
│  - Firestore (documents & security)     │
│  - Emulator (local development)         │
└─────────────────────────────────────────┘
```

## ✅ Verification Checklist

Run this to verify your setup:
```bash
# Check structure
ls bazi_fengshui_app/apps/
ls bazi_fengshui_app/packages/

# Check compiled functions
ls bazi_fengshui_app/apps/firebase_functions/lib/

# Check dependencies
cat bazi_fengshui_app/apps/firebase_functions/package.json | grep '"firebase'

# Test build
cd bazi_fengshui_app/apps/firebase_functions && npm run build
```

## 🚨 Recent Fixes Applied (Jan 13, 2026)

- ✅ Firebase Emulator: Fixed path in `firebase.json` → `bazi_fengshui_app/apps/firebase_functions`
- ✅ Dependencies: Upgraded `firebase-functions` 5.0.0 + `firebase-admin` 12.0.0
- ✅ Code Organization: Consolidated function exports in `index.ts`
- ✅ Template Literals: Fixed code fence markers using array.join() in `gemini.ts`
- ✅ Type Safety: Removed `zod-to-json-schema` (caused deep recursion errors)

---

**For detailed info, see**: [DEVELOPMENT_SETUP.md](./DEVELOPMENT_SETUP.md)  
**Architecture docs**: [ARCHITECTURE.md](./ARCHITECTURE.md)
