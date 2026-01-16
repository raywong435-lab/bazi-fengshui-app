# Local Development Setup Guide

## Prerequisites

- **Node.js**: v18 (required for Firebase Functions)
- **Java**: Required for Firebase emulator (typically comes with Android Studio)
- **Firebase CLI**: `npm install -g firebase-tools`

## A. Priority Fix Summary

### Issues Fixed:
1. ✅ **Firebase Emulator Failure**: `firebase.json` now correctly points to `bazi_fengshui_app/apps/firebase_functions`
2. ✅ **Dependency Conflicts**: Updated `firebase-admin` (^12.0.0) and `firebase-functions` (^5.0.0) for compatibility
3. ✅ **Removed `zod-to-json-schema`**: Eliminated "deep type instantiation" error by using manual JSON schema in prompts
4. ✅ **Template Literal Fix**: Replaced triple-backtick literals with array.join() pattern in gemini.ts
5. ✅ **Code Duplication**: Consolidated exports in index.ts
6. ✅ **API Key Consistency**: Single source of truth via `functions.config().gemini.key`

## B. Step-by-Step Command Sequence

Run these commands from the repo root directory (`C:\Users\raywo\AIBaZi` on Windows):

### Step 1: Verify Java Installation
```powershell
java -version
# If not found, install Java 11+ or use Android Studio bundled JDK
```

### Step 2: Install/Update Firebase CLI
```powershell
npm install -g firebase-tools
firebase --version
```

### Step 3: Navigate to Functions Directory & Install Dependencies
```powershell
cd bazi_fengshui_app/apps/firebase_functions
npm ci  # Use ci instead of install for locked dependencies
```

### Step 4: Set Gemini API Key in Functions Config
```powershell
# Option A: Via environment file (for emulator)
# Create or edit .env.local in functions directory:
echo "GEMINI_API_KEY=sk-..." >> .env.local

# Option B: Via Firebase CLI config (if using deployed functions)
firebase functions:config:set gemini.key="sk-..."
```

### Step 5: Build TypeScript Functions
```powershell
npm run build
# Verify lib/ directory was created with compiled .js files
```

### Step 6: Start Firebase Emulators (from repo root)
```powershell
cd ..\..  # Back to repo root
firebase emulators:start --only auth,firestore,functions --debug
# Should see: ✓ All emulators started successfully
```

### Step 7: Test Callable Function (in separate terminal)
```powershell
cd bazi_fengshui_app/apps/firebase_functions
npm run shell
# In the shell prompt:
createChart({ name: "Test", birthDate: "2000-01-15", birthTime: "14:30", timeZone: "Asia/Taipei", gender: "male" })
```

## C. File Changes Applied

### 1. `firebase.json`
- **Change**: Updated functions source path to `bazi_fengshui_app/apps/firebase_functions`
- **Reason**: Reflects new monorepo structure

### 2. `bazi_fengshui_app/apps/firebase_functions/package.json`
- **firebase-admin**: ^12.0.0 (was ^11.8.0)
- **firebase-functions**: ^5.0.0 (was ^4.3.1)
- **Removed**: `zod-to-json-schema` (not needed with manual schema)
- **Reason**: Eliminates peer dependency conflicts; `zod-to-json-schema` caused deep type errors

### 3. `bazi_fengshui_app/apps/firebase_functions/src/index.ts`
- **Change**: Reordered exports for clarity
- **Reason**: Single source of truth; prevents accidental duplication

### 4. `bazi_fengshui_app/apps/firebase_functions/src/services/gemini.ts`
- **New Function**: `buildBaziReportPrompt(birthData, chartData)`
- **Change**: Template literals now use array.join() to safely include code fences
- **Reason**: Avoids TypeScript compiler errors with triple-backticks

## D. Troubleshooting

### Issue: "No emulators to start"
**Solution**: Verify `firebase.json` exists at repo root and contains `emulators` section.
```powershell
firebase emulators:start --only functions --config firebase.json
```

### Issue: Port already in use (e.g., 5001)
**Solution**: Kill process on that port (PowerShell as Admin):
```powershell
netstat -ano | findstr :5001
taskkill /PID <PID> /F
```

### Issue: "Cannot find module 'firebase-functions'"
**Solution**: Reinstall dependencies:
```powershell
cd bazi_fengshui_app/apps/firebase_functions
rm -r node_modules package-lock.json
npm ci
```

### Issue: TypeScript compiler errors with template literals
**Solution**: Already fixed. If you see similar errors, use array.join() pattern:
```typescript
const prompt = [
  'Line 1',
  'Line 2 with ```json marker',
  'Line 3',
].join('\n');
```

## E. Final Verification

1. **Build succeeds**: `npm run build` produces `lib/` directory
2. **Emulator starts**: `firebase emulators:start --only functions` shows no errors
3. **Callable function works**: `createChart(...)` in functions:shell returns data
4. **No peer dependency warnings**: `npm install` completes without legacy-peer-deps flag

---

**Last Updated**: January 13, 2026
**Target Environment**: Node 18, Firebase Functions 5.x, Firebase Admin 12.x
