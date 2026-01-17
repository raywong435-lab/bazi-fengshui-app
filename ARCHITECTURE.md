# 系統架構完整指南 (Complete Integration Guide)

> **最後更新**: 2026年1月17日  
> **架構版本**: v1.0.0  
> **維護者**: Ray Wong

---

## 📋 專案結構總覽 (Project Structure Overview)

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

## 🏗️ 系統架構圖 (System Architecture)

### 三層架構概覽

```
┌─────────────────────────────────────────────────────────────┐
│                    Flutter Application                       │
│                  (apps/flutter_app/lib/)                    │
│                                                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │  Auth        │  │  Charts      │  │  Reports     │     │
│  │  Feature     │  │  Feature     │  │  Feature     │     │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘     │
│         │                 │                 │              │
│         └─────────────────┼─────────────────┘              │
│                           │                                │
│                  ┌────────▼────────┐                       │
│                  │ Riverpod State  │                       │
│                  │   Management    │                       │
│                  └────────┬────────┘                       │
│                           │                                │
│                  ┌────────▼────────┐                       │
│                  │ Firebase Client │                       │
│                  │   SDK (Auth,    │                       │
│                  │   Firestore)    │                       │
│                  └────────┬────────┘                       │
└───────────────────────────┼────────────────────────────────┘
                            │ HTTPS Callable Functions
                            │ (asia-east1)
┌───────────────────────────▼────────────────────────────────┐
│              Firebase Cloud Functions                       │
│            (apps/firebase_functions/src/)                   │
│                                                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │              Callable Functions                      │  │
│  │  ┌────────────────┐    ┌─────────────────┐          │  │
│  │  │  createChart   │    │ generateReport  │          │  │
│  │  │  - Zod驗證     │    │ - Quota檢查     │          │  │
│  │  │  - 八字計算    │    │ - Gemini AI呼叫│          │  │
│  │  └────────┬───────┘    └────────┬────────┘          │  │
│  └───────────┼──────────────────────┼───────────────────┘  │
│              │                      │                      │
│  ┌───────────▼──────────────────────▼───────────────────┐  │
│  │                Services Layer                        │  │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────────────┐   │  │
│  │  │ Gemini   │  │  Quota   │  │  Cache Service   │   │  │
│  │  │ Service  │  │ Tracker  │  │  (Firestore)     │   │  │
│  │  └────┬─────┘  └────┬─────┘  └────┬─────────────┘   │  │
│  └───────┼─────────────┼─────────────┼─────────────────┘  │
│          │             │             │                    │
│  ┌───────▼─────────────▼─────────────▼─────────────────┐  │
│  │            Validation & Error Handling              │  │
│  │  - Zod Schemas  - Custom Errors  - Type Safety     │  │
│  └──────────────────────────────────────────────────────┘  │
└───────────────────────────┬────────────────────────────────┘
                            │ Firestore API
┌───────────────────────────▼────────────────────────────────┐
│                  Firebase Backend                           │
│                    (asia-east1)                            │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              Firestore Database                     │   │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────────────┐  │   │
│  │  │  users/  │  │ charts/  │  │    reports/      │  │   │
│  │  │  {uid}   │  │ {chartId}│  │   {reportId}     │  │   │
│  │  └──────────┘  └──────────┘  └──────────────────┘  │   │
│  │                                                     │   │
│  │  ┌──────────────────────────────────────────────┐  │   │
│  │  │         Security Rules                       │  │   │
│  │  │  - 用戶只能存取自己的資料                      │  │   │
│  │  │  - 驗證配額限制                              │  │   │
│  │  └──────────────────────────────────────────────┘  │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │           Firebase Authentication                   │   │
│  │  - Email/Password                                   │   │
│  │  - Custom Claims (quota tracking)                  │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### 資料流向 (Data Flow)

#### 1. 生成八字命盤流程
```
用戶輸入 → Flutter UI → Riverpod Provider → 
Firebase Auth驗證 → createChart Function → 
lunar-typescript計算 → Firestore儲存 → 
返回Flutter顯示
```

#### 2. AI報告生成流程
```
Flutter請求 → generateReport Function → 
檢查Quota → 從Firestore讀取Chart → 
Gemini API (Zod驗證) → Firestore儲存Report → 
更新Quota → 返回Flutter
```

#### 3. 配額管理流程
```
Scheduled Task (每月1日) → resetMonthlyQuota → 
Firestore批次更新所有用戶 → 重置quota.monthly_count
```

## 📚 架構決策 (Architecture Decisions)

### 為什麼選擇 Monorepo？
- ✅ **統一版本控制**：前端 + 後端同步開發
- ✅ **型別共享**：`packages/shared_types/` 跨平台使用
- ✅ **統一建置流程**：單一 CI/CD pipeline
- ✅ **程式碼重用**：避免重複定義資料結構
- ✅ **原子性提交**：相關變更一次 commit

### 為什麼 Flutter 採用 Feature-First 架構？
- ✅ **業務導向**：依功能（auth、charts、reports）而非技術層分類
- ✅ **易於定位**：快速找到相關程式碼
- ✅ **團隊協作**：不同功能由不同團隊負責，減少衝突
- ✅ **可擴展性**：新增功能只需新增 feature 目錄

### 為什麼 Functions 分離 Entry Point？
- ✅ **清晰導出**：`index.ts` 只負責 export，不含實作
- ✅ **避免重複**：防止意外定義多個同名函數
- ✅ **易於理解**：一眼看出有哪些 callable functions
- ✅ **關注點分離**：實作邏輯在各自模組中

### 為什麼使用 Zod 而非 TypeScript Interface？
- ✅ **執行期驗證**：TypeScript 僅編譯期檢查
- ✅ **資料清理**：自動過濾多餘欄位
- ✅ **錯誤訊息**：提供詳細的驗證失敗原因
- ✅ **型別推導**：從 schema 自動生成 TypeScript 型別

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

## 📞 聯絡與支援 (Contact & Support)

**專案維護者**: Ray Wong (raywong435)  
**架構版本**: v1.0.0  
**最後更新**: 2026年1月17日  

**技術堆疊**:
- Monorepo (Melos)
- Feature-First Flutter + Riverpod
- TypeScript Cloud Functions
- Firebase (Firestore + Auth)
- Gemini AI

**相關文件**:
- [快速開始指南](./QUICK_START_GUIDE.md)
- [開發環境設定](./DEVELOPMENT_SETUP.md)
- [快速參考卡](./QUICK_REFERENCE.md)
- [版本更新記錄](./CHANGELOG.md)
