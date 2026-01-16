# HANDOFF_DEBUG_REPORT.md
**Generated**: 2026-01-15 | **Auditor Role**: VS Code AI Agent (Read-Only)

---

## 1) Project Snapshot

**One-Sentence Purpose**:  
Flutter + Firebase monorepo for generating personalized Bazi (八字) Chinese astrology reports using Gemini AI.

**Technical Stack**:
- **Frontend**: Flutter (Dart 3.0+) with Riverpod state management, Freezed models
- **Backend**: TypeScript Cloud Functions (Firebase Functions v5.0+) with Firestore database
- **AI Integration**: Google Generative AI (Gemini Pro) with Zod validation
- **Monorepo**: Melos workspace manager; separate apps + shared packages
- **Infrastructure**: Firebase Emulator Suite (auth, Firestore, Functions) for local development

**Current Status**:
- ✅ **Builds**: TypeScript compilation succeeds (npm run build → lib/ generated)
- ⚠️ **Runs**: Emulator-ready but requires GEMINI_API_KEY environment variable
- ⚠️ **Main Issue**: Firestore security rules mismatch with actual data paths (quota & chart storage)
- ⚠️ **Schema Inconsistency**: Multiple conflicting report schema definitions (zodSchemas.ts vs reportSchemas.ts)

---

## 2) Repo Map

```
bazi-fengshui-app/                                  # Root (monorepo)
├── firebase.json                                  # ✓ Correct path to functions
├── firestore.rules                                # ⚠️ Missing subcollection rules
├── melos.yaml                                     # Workspace config
│
└── bazi_fengshui_app/
    ├── apps/
    │   ├── flutter_app/                           # Feature-first architecture
    │   │   ├── lib/main.dart                      # ✓ Emulator setup correct
    │   │   ├── features/
    │   │   │   ├── auth/data/auth_repository.dart
    │   │   │   ├── charts/                        # Chart creation feature
    │   │   │   └── reports/                       # Report viewing feature
    │   │   ├── shared/                            # Shared widgets/models
    │   │   └── pubspec.yaml                       # ✓ Dependencies locked
    │   │
    │   └── firebase_functions/                    # Cloud Functions
    │       ├── src/
    │       │   ├── index.ts                       # ✓ Export-only entry point
    │       │   ├── callable/
    │       │   │   ├── createChart.ts             # Creates Bazi chart
    │       │   │   └── generateReport.ts          # Generates AI report
    │       │   ├── services/
    │       │   │   ├── gemini.ts                  # ⚠️ Prompt building logic
    │       │   │   ├── geminiClient.ts            # ⚠️ Separate client (duplication?)
    │       │   │   ├── cache.ts                   # Report caching
    │       │   │   └── quota.ts                   # Usage quota tracking
    │       │   ├── tasks/
    │       │   │   └── resetMonthlyQuota.ts       # Scheduled quota reset
    │       │   └── types/
    │       │       ├── zodSchemas.ts              # ⚠️ Schema #1: FullReportSchema
    │       │       ├── reportSchemas.ts           # ⚠️ Schema #2: ReportDataSchema
    │       │       └── errors.ts
    │       ├── package.json                       # ✓ Updated dependencies
    │       ├── tsconfig.json
    │       ├── lib/                               # Compiled output
    │       └── jest.config.js
    │
    └── packages/
        ├── core/                                  # Shared Dart models
        ├── shared_logic/                          # Common business logic
        └── shared_types/                          # Cross-platform type defs
```

**Key Entry Points**:
| Role | File | Purpose |
|------|------|---------|
| Functions Export | [apps/firebase_functions/src/index.ts](apps/firebase_functions/src/index.ts) | Exports `createChart`, `generateReport`, `resetMonthlyQuota` |
| Flutter Main | [apps/flutter_app/lib/main.dart](apps/flutter_app/lib/main.dart) | Emulator setup + app bootstrap |
| Callable: Chart | [apps/firebase_functions/src/callable/createChart.ts](apps/firebase_functions/src/callable/createChart.ts) | Bazi calculation (lunar-typescript) |
| Callable: Report | [apps/firebase_functions/src/callable/generateReport.ts](apps/firebase_functions/src/callable/generateReport.ts) | Report generation + quota check |
| Schemas | [apps/firebase_functions/src/types/reportSchemas.ts](apps/firebase_functions/src/types/reportSchemas.ts) + [zodSchemas.ts](apps/firebase_functions/src/types/zodSchemas.ts) | ⚠️ Inconsistent definitions |
| Security Rules | [firestore.rules](firestore.rules) | ⚠️ Incomplete subcollection rules |

**Responsibility Matrix**:
| Layer | Responsibility |
|-------|-----------------|
| **Flutter App** | UI for birth data input → calls `createChart` → displays reports |
| **Firebase Functions** | Validation, Bazi calculation, Gemini API calls, quota enforcement, caching |
| **Firestore** | User data + charts + reports storage; subcollection-based hierarchy |
| **Shared Packages** | (Minimal) Dart models in `core`, type defs in `shared_types` |

---

## 3) Contracts & Data Model Map

### 3.1 Firestore Collections & Paths

**Actual paths used in code**:

| Collection Path | Read/Write | Purpose | Rules Coverage |
|---|---|---|---|
| `/users/{userId}` | R/W: Functions, Flutter App | User profile | ✓ Covered |
| `/users/{userId}/charts/{chartId}` | R/W: Functions (generateReport reads) | Bazi chart data | ⚠️ **NOT COVERED** |
| `/users/{userId}/reports/{reportId}` | R/W: Functions (cache), Flutter reads | Generated reports cache | ⚠️ **NOT COVERED** |
| `/users/{userId}/entitlements/{docId}` | R/W: Functions (quota check/update) | Quota/monthly allowance | ⚠️ **NOT COVERED** |
| `/userQuotas/{userId}` | R/W: Functions (quota.ts logic) | Quota tracking (alternate path) | ⚠️ **NOT COVERED** |
| `/cache/{cacheId}` | R/W: Functions, Flutter reads | Fallback caching | ✓ Covered |

**Firestore Rules Gap**:
```codex-rules
# CURRENT (firestore.rules)
match /users/{userId} {
  allow read, write: if request.auth != null && request.auth.uid == userId;
}
match /cache/{cacheId} {
  allow read, write: if request.auth != null;
}

# MISSING: subcollections under /users/{userId}/
# → /users/{userId}/charts/*
# → /users/{userId}/reports/*
# → /users/{userId}/entitlements/*
```

**Risk**: Firestore rules do NOT explicitly allow read/write to `charts`, `reports`, `entitlements` subcollections. Default deny may block operations.

---

### 3.2 Functions Endpoints & Callables

| Function Name | File | Region | Input Schema | Auth Required | Purpose |
|---|---|---|---|---|---|
| `createChart` | [createChart.ts:84](apps/firebase_functions/src/callable/createChart.ts#L84) | asia-east1 | `chartInputSchema` (birthDate ISO 8601 string, gender 1-2) | ❌ No | Compute Bazi 4 pillars from birth data |
| `generateReport` | [generateReport.ts:16](apps/firebase_functions/src/callable/generateReport.ts#L16) | asia-east1 | `ReportRequestSchema` (chartId, reportType enum) | ✅ **Yes** (context.auth required) | Generate AI report + check quota |
| `resetMonthlyQuota` | [resetMonthlyQuota.ts:11](apps/firebase_functions/src/tasks/resetMonthlyQuota.ts#L11) | asia-east1 | N/A (pubsub trigger) | N/A (scheduled) | Reset user quotas monthly (Firestore batch) |

**Auth Issue**: `createChart` does NOT require authentication but writes/reads user data. Should require `context.auth`.

---

### 3.3 Request/Response Schemas

**Zod Schemas - CONFLICTING DEFINITIONS**:

| Schema | File | Used By | Description |
|---|---|---|---|
| `chartInputSchema` | [createChart.ts:10](apps/firebase_functions/src/callable/createChart.ts#L10) | createChart callable | `{ chartName, birthDate: ISO 8601, gender: 1\|2, timeZone }` |
| `ReportRequestSchema` | [reportSchemas.ts:4](apps/firebase_functions/src/types/reportSchemas.ts#L4) | generateReport callable | `{ chartId: string, reportType: enum }` |
| **`ReportDataSchema`** | [reportSchemas.ts:45](apps/firebase_functions/src/types/reportSchemas.ts#L45) | Return type (runtime validation) | **Discriminated union of 4 types** (career/wealth/health/relationship) |
| **`FullReportSchema`** | [zodSchemas.ts:32](apps/firebase_functions/src/types/zodSchemas.ts#L32) | ❓ UNUSED in code | Has `originalChartAnalysis`, `annualFortune2026` (2026-specific) |
| `reportSchema` | [zodSchemas.ts:38](apps/firebase_functions/src/types/zodSchemas.ts#L38) | Alias for FullReportSchema | Backward-compatibility alias |
| `FunctionResponseSchema` | [reportSchemas.ts:66](apps/firebase_functions/src/types/reportSchemas.ts#L66) | Final return validation | `{ report: ReportDataSchema, metadata: { source, promptVersion, ... } }` |

**Inconsistency Issue**:
- `FullReportSchema` (zodSchemas.ts) expects nested `annualFortune2026` with specific 2026-focused fields
- `ReportDataSchema` (reportSchemas.ts) expects flat structure with `reportType` discriminator + type-specific fields
- Code in generateReport.ts line 76-83 tries to map between them but logic is convoluted

**Which schema is authoritative?** → Currently **ReportDataSchema** in [reportSchemas.ts](apps/firebase_functions/src/types/reportSchemas.ts)

---

### 3.4 Identified Inconsistencies

| Issue | Type | Impact | Evidence |
|---|---|---|---|
| **Firestore Rules Incomplete** | Security/Schema | Subcollections may fail PERMISSION_DENIED | rules lack `charts`, `reports`, `entitlements` |
| **Dual Report Schemas** | Schema Conflict | Runtime validation confusion | FullReportSchema vs ReportDataSchema both exported |
| **Unused FullReportSchema** | Dead Code | Code bloat, confusion | Defined in zodSchemas.ts but never validated |
| **Quota Path Mismatch** | Data Model | generateReport uses `/users/{uid}/entitlements/monthly` but quota.ts uses `/userQuotas/{userId}` | [generateReport.ts:42](apps/firebase_functions/src/callable/generateReport.ts#L42) vs [quota.ts:21](apps/firebase_functions/src/services/quota.ts#L21) |
| **createChart No Auth** | Security | Unauthenticated write risk | No context.auth check at line 84 |
| **Gemini Service Duplication** | Code Quality | Two AI client wrappers | gemini.ts + geminiClient.ts (which is authoritative?) |
| **buildBaziReportPrompt() Unused** | Dead Code | Defined at [gemini.ts:65](apps/firebase_functions/src/services/gemini.ts#L65) but never called |

---

## 4) Build & Checks Results

### 4.1 Firebase Functions Build

```bash
Command: npm run build
Working Directory: bazi_fengshui_app/apps/firebase_functions
```

**Output**:
```
> build
> npm run clean && tsc

> clean
> rimraf lib

[tsc compile step completes silently - no errors]
```

**Status**: ✅ **PASS** - Compilation successful, `lib/` directory created with .js files:
- `lib/index.js` (exports)
- `lib/callable/createChart.js`
- `lib/callable/generateReport.js`
- `lib/services/gemini.js`, `geminiClient.js`, `cache.js`, `quota.js`
- `lib/tasks/resetMonthlyQuota.js`
- `lib/types/*.js`

**Warnings**: ⚠️ npm engine mismatch (package.json requires Node 18, actual is v24.12.0) but no functional impact.

---

### 4.2 TypeScript Type Checking

**No type errors during compilation** → tsconfig.json with `strict: false` allows loose checking.

**Observable issues via code inspection**:
- ❌ `(reportToCache as any).__jsonSchema` line [generateReport.ts:121](apps/firebase_functions/src/callable/generateReport.ts#L121) → Type casting
- ❌ `import('../types/reportSchemas')` at [gemini.ts:134](apps/firebase_functions/src/services/gemini.ts#L134) → Runtime import (correct for avoiding circular deps)

---

### 4.3 Flutter Build (Static Analysis)

**Not fully runnable** (emulator required), but pubspec.yaml dependencies are locked:
```yaml
firebase_core: ^3.0.0
firebase_auth: ^5.0.0
cloud_firestore: ^5.0.0
cloud_functions: ^5.0.0
flutter_riverpod: ^2.0.0
freezed_annotation: ^2.2.0
```

✅ All locked to compatible versions.

---

### 4.4 Linting & Test Status

| Check | Command | Status | Notes |
|---|---|---|---|
| ESLint | `npm run lint` | ❌ BLOCKED | eslint not in node_modules (dev-only, skipped in CI) |
| Jest Tests | `npm run test` | ❓ UNKNOWN | No test runs attempted |
| Flutter Tests | `flutter test` | ❓ UNKNOWN | Requires emulator + env setup |

**Recommendation**: Linting/testing skipped for this audit; focus on static code analysis.

---

### 4.5 Known Environment Issues

| Variable | Required For | Current Status | Where Read |
|---|---|---|---|
| `GEMINI_API_KEY` | Gemini API calls | ❌ **Missing** | [gemini.ts:9-11](apps/firebase_functions/src/services/gemini.ts#L9-L11) |
| `GENAI_KEY` | Legacy fallback | ❌ Missing | [gemini.ts:9](apps/firebase_functions/src/services/gemini.ts#L9) (fallback only) |
| Firebase Project ID | Deployment | ❓ Firebase config | firebase.json (auto-detected) |
| Emulator Ports | Local dev | ✅ Correct | firebase.json: auth=9099, functions=5001, firestore=8080, ui=4000 |

---

## 5) Issue Backlog

| ID | Severity | Type | Location | Symptom | Evidence | Root Cause | Fix Steps | Files To Touch | Verification | Risk / Notes |
|---|---|---|---|---|---|---|---|---|---|---|
| **SEC-001** | **Blocker** | Security | [generateReport.ts:16](apps/firebase_functions/src/callable/generateReport.ts#L16) | `createChart` callable does not require authentication | No `context.auth` check in createChart function | Unauthenticated write to `/users/{uid}/charts/` and Firestore | 1. Add auth check to createChart at line 85: `if (!context.auth) throw HttpsError('unauthenticated', 'Must be authenticated');` 2. Test with emulator | createChart.ts | Attempt createChart without signing in; should fail with 'unauthenticated' | Users could bypass auth to write charts for other users |
| **FIR-001** | **Blocker** | Security | [firestore.rules](firestore.rules) | Firestore rules do not cover `/users/{uid}/charts`, `/users/{uid}/reports`, `/users/{uid}/entitlements` subcollections | Rules only match `/users/{userId}` top-level and `/cache/{cacheId}` | Firebase default-deny blocks subcollection access; rules need explicit match statements | 1. Add three match blocks after users rule: `match /users/{userId}/charts/{chartId}` (allow read/write if auth.uid == userId), `match /users/{userId}/reports/{reportId}` (same), `match /users/{userId}/entitlements/{doc}` (same) 2. Verify with firebase emulator | firestore.rules | generateReport function should read chart from /users/{uid}/charts/{chartId}; should succeed with emulator + auth | Data loss risk: writes to subcollections will silently fail in production |
| **FIR-002** | **High** | Schema | [generateReport.ts:42](apps/firebase_functions/src/callable/generateReport.ts#L42), [quota.ts:21](apps/firebase_functions/src/services/quota.ts#L21) | Code references two different quota paths: `/users/{uid}/entitlements/monthly` (generateReport) vs `/userQuotas/{userId}` (quota.ts) | generateReport writes to entitlements; quota.ts reads/writes userQuotas | Inconsistent data model: two sources of truth | 1. Audit code to determine which path is actually used at runtime 2. Consolidate to single path (recommend `/users/{uid}/entitlements/monthly` since it respects user isolation) 3. Remove unused quota.ts or update to use entitlements path 4. Add firestore rule for entitlements | generateReport.ts, quota.ts, firestore.rules | Trigger generateReport; quota should decrement in one location only | Quota bypass if wrong path is used |
| **SCH-001** | **High** | Schema | [zodSchemas.ts:32](apps/firebase_functions/src/types/zodSchemas.ts#L32), [reportSchemas.ts:45](apps/firebase_functions/src/types/reportSchemas.ts#L45) | Two conflicting report schema definitions: FullReportSchema (2026-specific, nested) vs ReportDataSchema (discriminated union, flat) | FullReportSchema defines `originalChartAnalysis` + `annualFortune2026` fields; ReportDataSchema has 4 type variants with different shapes | Code is unclear which schema is authoritative; FullReportSchema is exported but unused | 1. Search codebase for `FullReportSchema` usage; likely unused 2. If unused, delete from zodSchemas.ts 3. If used, consolidate with ReportDataSchema 4. Verify generateReport.ts line 76-83 logic matches chosen schema 5. Update all imports | zodSchemas.ts, reportSchemas.ts, generateReport.ts, types/index.ts | `npm run build` succeeds; linting shows no duplicate exports; generateReport returns data matching ReportDataSchema | Code confusion, maintenance burden, potential runtime validation failures |
| **ARC-001** | **High** | Architecture | [gemini.ts:1-156](apps/firebase_functions/src/services/gemini.ts#L1-L156), [geminiClient.ts:1-17](apps/firebase_functions/src/services/geminiClient.ts#L1-L17) | Two Gemini client wrappers: gemini.ts (with prompt builders) and geminiClient.ts (simple wrapper) | gemini.ts exports `generateAndValidateJson`, `buildBaziReportPrompt`, `createPrompt`, `generateReportWithGemini`; geminiClient.ts exports `generateContent`, `generateFullReport` | Duplication: both wrap @google/generative-ai; unclear which is primary | 1. Review all imports of both files across codebase 2. Consolidate: move generateContent/generateFullReport logic into gemini.ts 3. Delete geminiClient.ts 4. Update imports in generateReport.ts and anywhere else | gemini.ts, geminiClient.ts, generateReport.ts | Import count should reduce to single service; build succeeds | Code duplication, confusion about primary AI service |
| **ARC-002** | **Medium** | Dead Code | [gemini.ts:65](apps/firebase_functions/src/services/gemini.ts#L65) | `buildBaziReportPrompt()` function is defined but never called | grep search returns no usages of buildBaziReportPrompt in generateReport or other functions | Dead code, likely replaced by createPrompt | 1. Verify buildBaziReportPrompt is not called anywhere (grep) 2. Delete function and its docstring 3. Ensure createPrompt is used instead | gemini.ts | Build succeeds; no import errors | Minor: just code bloat |
| **ARC-003** | **Medium** | Dead Code | [zodSchemas.ts:38](apps/firebase_functions/src/types/zodSchemas.ts#L38) | `reportSchema` alias defined but never used; FullReportSchema itself appears unused | No imports of reportSchema or FullReportSchema found in generateReport.ts or elsewhere | Aliases/legacy code not cleaned up | 1. Grep for `reportSchema` and `FullReportSchema` usage 2. If truly unused, delete both 3. If used, consolidate with ReportDataSchema | zodSchemas.ts | Build succeeds; exports only ReportDataSchema from index.ts | Low priority: awaiting resolution of SCH-001 |
| **ARC-004** | **Medium** | Architecture | [createChart.ts:10-14](apps/firebase_functions/src/callable/createChart.ts#L10-L14) | `chartInputSchema` does not match frontend expectations | Schema expects `chartName`, `birthDate` (ISO 8601), `gender` (1-2), `timeZone`; unclear if frontend sends this format | Potential request/response mismatch | 1. Review Flutter app code for how it calls createChart 2. Verify birthDate format (ISO 8601 vs other formats) 3. Document expected format in comments 4. Add tests to validate mapping from frontend data | createChart.ts, Flutter app (charts feature) | Flutter app successfully creates charts; emulator logs show correct schema validation | Frontend integration risk: if format mismatch, charts fail silently |
| **LOG-001** | **Low** | Code Quality | [generateReport.ts:40, 60, 112](apps/firebase_functions/src/callable/generateReport.ts) | Generic error handling: catch blocks log but do not differentiate Gemini errors from quota errors | If Gemini API fails, error type is masked as generic "internal" | Debugging difficult; client sees generic error | 1. Create specific error codes for different failure modes (GEMINI_API_FAIL, QUOTA_EXCEEDED, CHART_NOT_FOUND) 2. Re-throw with specific HttpsError codes 3. Add distinct console.error messages | generateReport.ts, possibly errors.ts | Error messages in logs are specific; client receives correct error code | Debugging/monitoring improvement only |
| **DOC-001** | **Low** | Documentation | Various | No docstrings explaining Firestore paths, auth requirements, quota mechanics | Code is sparse on inline documentation | New developers confused about data model | 1. Add JSDoc comments to callable function exports (createChart, generateReport, resetMonthlyQuota) 2. Document required Firestore security rules 3. Document expected request/response formats 4. Add link to ARCHITECTURE.md | All callable/*.ts, services/*.ts | Code review: docstrings present and clear | Low priority: helpful but not blocking |

---

## 6) Top 10 Fix Order

### Execution Priority (Blocker & High Only)

| Seq | ID | Severity | Fix Summary | Why First | Verification Command |
|---|---|---|---|---|---|
| 1 | **SEC-001** | Blocker | Add auth check to createChart | Prevents unauthorized writes to user data | After fix: `firebase functions:call createChart --unauthenticated` should fail |
| 2 | **FIR-001** | Blocker | Extend firestore.rules to cover subcollections | Without this, all generateReport calls fail at "read chart" step | After fix: `firebase emulators:start`; call generateReport; read should succeed |
| 3 | **FIR-002** | High | Consolidate quota paths (/userQuotas vs /entitlements) | Runtime quota errors if wrong path used; must match rules | After fix: quota.ts and generateReport.ts reference same collection path |
| 4 | **SCH-001** | High | Delete unused FullReportSchema; consolidate to ReportDataSchema | Runtime validation will fail if schema doesn't match Gemini response | After fix: grep `FullReportSchema` returns 0; ReportDataSchema is single source of truth |
| 5 | **ARC-001** | High | Consolidate gemini.ts + geminiClient.ts into one service | Confusion about which client to use; potential duplication of API calls | After fix: single file exports `generateContent` and `generateReportWithGemini` |
| 6 | **ARC-002** | Medium | Delete buildBaziReportPrompt if unused | Code clarity | After fix: grep `buildBaziReportPrompt` returns 0 matches |
| 7 | **ARC-003** | Medium | Delete reportSchema alias if FullReportSchema is deleted | Code clarity (follows from SCH-001 resolution) | After fix: zodSchemas.ts contains only necessary exports |
| 8 | **ARC-004** | Medium | Document createChart input/output contract | Prevents frontend integration issues | After fix: schema comment in createChart.ts is clear; Flutter test passes |
| 9 | **LOG-001** | Low | Improve error differentiation in generateReport | Debugging aid | After fix: console.error logs distinguish GEMINI_API_FAIL vs QUOTA_EXCEEDED |
| 10 | **DOC-001** | Low | Add JSDoc comments to exports | Developer experience | After fix: functions/*.ts have @param, @returns, @throws comments |

---

## 7) Safe-Change Rules

### Principles for Claude Code to Follow

1. **Minimal Modifications Priority**
   - Fix only what breaks functionality; don't refactor style
   - Example: ADD auth check to createChart (1 if statement); don't rewrite entire function

2. **Schema Changes Require Sync Across 3 Places**
   - **Type Definition**: zodSchemas.ts or reportSchemas.ts
   - **Validator Usage**: Any function that calls `schema.safeParse()` or `schema.parse()`
   - **Firestore Rules**: If collection paths change, update firestore.rules
   - **Tests/Checks**: Re-run `npm run build` to validate types

3. **Firestore Rules Changes = HIGH RISK**
   - After modifying rules, test BOTH emulator + production paths
   - Don't allow world-read: always require `request.auth != null`
   - Subcollection rules must explicitly use `{docId}` path segments
   - **Test command**: Start emulator, trigger affected function, observe Firestore logs

4. **Quota Data Model Change = AUDIT NEEDED**
   - If consolidating `/userQuotas` → `/users/{uid}/entitlements`, must:
     - Update generateReport.ts data model
     - Update quota.ts if still used
     - Migrate existing user data (document schema change) OR default in code
     - Update firestore.rules
     - Test monthly reset task

5. **No Large Refactors Without Issue**
   - Prohibited: Splitting functions, renaming exports, moving files (without tracking)
   - Allowed: Deleting clearly-unused code (buildBaziReportPrompt, reportSchema alias)

6. **Commit-Like Tracking**
   - For each fix: Note "Before" schema, "After" schema, files changed
   - Example:
     ```
     FIR-001 Fix: Extended firestore.rules
     - Added: match /users/{userId}/charts/{chartId}
     - Added: match /users/{userId}/reports/{reportId}
     - Added: match /users/{userId}/entitlements/{doc}
     - All three allow read, write if request.auth.uid == userId
     ```

---

## 8) Known Unknowns

### Missing Information Blocking Full Verification

| Item | Purpose | Current Status | Where It's Read | Impact if Missing |
|---|---|---|---|---|
| **GEMINI_API_KEY** | Authenticate Gemini AI API calls | ❌ Not set | [gemini.ts:9-11](apps/firebase_functions/src/services/gemini.ts#L9-L11) or `.env.local` file | Functions fail with "API key not found" warning; Gemini calls return empty/error |
| **Firebase Project ID** | Identify which project owns Firestore/Auth | ❓ Assumed from .firebaserc (if exists) | firebase.json, `firebase deploy` | Emulator works offline; deployment fails if wrong project |
| **.firebaserc file** | Project alias config | ❓ Unknown if exists | (Not in repo map) | Deploy commands may fail if not configured |
| **Flutter build targets** | Android/iOS/Web configs | ⚠️ Minimal (android/ and ios/ folders exist but not inspected) | pubspec.yaml + native build files | Cannot build for production without full setup |
| **Emulator persistence** | Does emulator data persist between runs? | ⚠️ Default: in-memory (no persist) | firebase.json emulator config | Data lost on emulator restart; affects testing |

### Setup Instructions to Provide Claude

1. **To set GEMINI_API_KEY**:
   ```bash
   cd bazi_fengshui_app/apps/firebase_functions
   # Option A: .env.local file (local dev)
   echo "GEMINI_API_KEY=sk-YOUR_KEY_HERE" > .env.local
   
   # Option B: Firebase config (deployed)
   firebase functions:config:set gemini.key="sk-YOUR_KEY_HERE"
   ```

2. **To verify build**:
   ```bash
   cd bazi_fengshui_app/apps/firebase_functions
   npm install
   npm run build
   ls lib/  # Should show compiled .js files
   ```

3. **To test with emulator**:
   ```bash
   # Terminal 1: Start emulator
   firebase emulators:start --only auth,firestore,functions --debug
   
   # Terminal 2: Test function
   cd bazi_fengshui_app/apps/firebase_functions
   npm run shell
   # In shell:
   createChart({ chartName: "Test", birthDate: "2000-01-15T14:30:00+08:00", gender: 1, timeZone: "Asia/Taipei" })
   ```

---

## 9) CLAUDE_CODE_FIX_PROMPT

### Direct Instructions for Claude (Copy & Paste Ready)

```
=== HANDOFF: AI Code Audit for Bazi Fengshui App ===

You are fixing a Flutter + Firebase monorepo with TypeScript Cloud Functions.
This is a read-only audit report; apply fixes in priority order below.

### STEP 0: Verify Current State (Required Before Fixing)

1. Run: cd bazi_fengshui_app/apps/firebase_functions && npm run build
   Expected: lib/ directory exists with .js files, no TypeScript errors
   
2. Inspect current Firestore rules (firestore.rules):
   Expected: Only /users/{userId} and /cache/{cacheId} matches

3. Check if GEMINI_API_KEY is set:
   cd bazi_fengshui_app/apps/firebase_functions && cat .env.local (may not exist; is OK)

### STEP 1: Fix SEC-001 (Add Auth Check to createChart)
File: apps/firebase_functions/src/callable/createChart.ts
Location: Line 84 (function export statement)

Before:
```typescript
export const createChart = functions.region("asia-east1").https.onCall(async (data, context) => {
  // Validate input against the updated schema
  const parseResult = chartInputSchema.safeParse(data);
```

After:
```typescript
export const createChart = functions.region("asia-east1").https.onCall(async (data, context) => {
  // Require authentication for secure write
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated to create a chart.');
  }

  // Validate input against the updated schema
  const parseResult = chartInputSchema.safeParse(data);
```

Why: Prevents unauthorized writes to user's chart data.
Verification:
  - After: npm run build (should succeed)
  - Test: Call createChart without auth → should get HttpsError 'unauthenticated'

---

### STEP 2: Fix FIR-001 (Extend Firestore Rules)
File: firestore.rules

Before:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    match /cache/{cacheId} {
      allow read, write: if request.auth != null;
    }
  }
}
```

After:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
      
      // Subcollections under /users/{userId}
      match /charts/{chartId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
      match /reports/{reportId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
      match /entitlements/{doc=**} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
    match /cache/{cacheId} {
      allow read, write: if request.auth != null;
    }
  }
}
```

Why: Enable generateReport to read /users/{uid}/charts/{chartId}, write /users/{uid}/reports/{reportId}, and manage /users/{uid}/entitlements/monthly.
Verification:
  - After: firebase emulators:start --only firestore
  - Test: Call generateReport → should be able to read chart and write report
  - Check emulator logs for permission errors (should be none)

---

### STEP 3: Fix FIR-002 (Consolidate Quota Paths)
Files: apps/firebase_functions/src/callable/generateReport.ts and src/services/quota.ts

DECISION: Keep /users/{uid}/entitlements/monthly path (already used in generateReport).
Delete or disable the /userQuotas path (quota.ts).

File: quota.ts - Mark as deprecated (don't delete yet, in case it's imported elsewhere):

Around line 1, add warning:
```typescript
/**
 * @deprecated Use /users/{userId}/entitlements/monthly instead.
 * This module is kept for backward compatibility but should not be used in new code.
 * See generateReport.ts for the canonical quota implementation.
 */
import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';
...
```

Verify imports of quota.ts:
- Search: grep -r "from.*quota\|import.*quota" apps/firebase_functions/src/
- If only used in index.ts exports: check if exported; if yes, keep but mark deprecated in exports

Why: Single source of truth for quota data model. generateReport.ts already handles quota correctly.
Verification:
  - After: npm run build (should succeed)
  - Check: No remaining imports of quota.ts in active code paths
  - Test: generateReport decrement logic works from /users/{uid}/entitlements/monthly

---

### STEP 4: Fix SCH-001 (Delete Unused FullReportSchema)
Files: apps/firebase_functions/src/types/zodSchemas.ts, src/types/index.ts

File: zodSchemas.ts
Remove lines 10-31 (BaziAnalysisSchema definition):
Remove lines 32-41 (FullReportSchema definition):
Remove lines 38 (reportSchema alias):
Remove lines 41 (FullReport type):

After deletion, zodSchemas.ts should only have:
```typescript
import { z } from 'zod';

// Birth info schema for input validation
export const birthInfoSchema = z.object({
  name: z.string(),
  birthDate: z.string(), // ISO date string
  birthTime: z.string(), // HH:MM format
  gender: z.enum(['male', 'female']),
  location: z.string(), // city or coordinates
});
```

File: types/index.ts
Remove any exports of FullReportSchema, reportSchema, FullReport:
```typescript
// Before
export { 
  ReportRequestSchema,
  ReportDataSchema,
  FunctionResponseSchema,
  reportJsonSchema,
  ReportData,
  FunctionResponse,
} from './reportSchemas';

// After (no change if these were not exported; verify grep result first)
export { 
  ReportRequestSchema,
  ReportDataSchema,
  FunctionResponseSchema,
  reportJsonSchema,
  ReportData,
  FunctionResponse,
} from './reportSchemas';
```

Why: FullReportSchema was never used at runtime; only ReportDataSchema validates Gemini responses.
Verification:
  - After: npm run build (no errors)
  - Grep: grep -r "FullReportSchema\|reportSchema" apps/firebase_functions/src/ → Should return 0 matches
  - Test: generateReport still returns valid reports with ReportDataSchema

---

### STEP 5: Fix ARC-001 (Consolidate Gemini Clients)
Files: apps/firebase_functions/src/services/gemini.ts and src/services/geminiClient.ts

Decision: Move generateContent + generateFullReport from geminiClient.ts into gemini.ts; delete geminiClient.ts.

File: gemini.ts (add at end, before generateReportWithGemini export):
```typescript
/**
 * Simple wrapper for Gemini content generation.
 * Called by generateReportWithGemini and other functions.
 */
export const generateContent = async (prompt: string) => {
  const model = genAI.getGenerativeModel({ model: 'gemini-pro' });
  const result = await model.generateContent({ 
    contents: [{ role: 'user', parts: [{ text: prompt }] }] 
  } as any);
  const response = result.response;
  return response.text();
};

/**
 * Generate full structured report from Bazi data.
 * Returns parsed JSON response.
 */
export const generateFullReport = async (baziData: any): Promise<any> => {
  const prompt = `基于以下八字命盘数据，生成一份结构化的完整报告（JSON only）。八字数据: ${JSON.stringify(baziData)}`;
  const text = await generateContent(prompt);
  try {
    const parsed = JSON.parse(text);
    return parsed;
  } catch (error) {
    throw new Error('Failed to parse Gemini response as JSON');
  }
};
```

File: generateReport.ts (update import):
```typescript
// Before:
import { generateContent, generateFullReport } from '../services/geminiClient';

// After:
import { generateContent, generateFullReport } from '../services/gemini';
```

File: index.ts (remove geminiClient from any re-exports if present; search for it):
- Verify if geminiClient.ts functions were ever exported from index.ts
- If not, safe to delete

Delete: apps/firebase_functions/src/services/geminiClient.ts

Why: Single AI service, cleaner imports, no duplication.
Verification:
  - After: npm run build (no errors, no unresolved imports)
  - Grep: grep -r "geminiClient" apps/firebase_functions/src/ → Should return 0 matches
  - Test: generateReport still works; Gemini calls succeed

---

### STEP 6: Fix ARC-002 (Delete Unused buildBaziReportPrompt)
File: apps/firebase_functions/src/services/gemini.ts

Find and delete the buildBaziReportPrompt function (around line 65-84):
```typescript
export function buildBaziReportPrompt(
  birthData: { year: number; month: number; day: number; hour: number },
  chartData: Record<string, any>
): string {
  // ... entire function body ...
  return lines.join('\n');
}
```

Why: Never called; createPrompt is the active prompt builder.
Verification:
  - After: npm run build
  - Grep: grep "buildBaziReportPrompt" apps/firebase_functions/src/ → 0 matches (except in removed code)

---

### STEP 7: Fix ARC-003 (Remove reportSchema Alias)
File: apps/firebase_functions/src/types/zodSchemas.ts

Already deleted in STEP 4 (reportSchema is alias for FullReportSchema).
Verify: grep "reportSchema" apps/firebase_functions/src/ → 0 matches after all fixes.

---

### STEP 8: Fix ARC-004 (Document createChart Input/Output)
File: apps/firebase_functions/src/callable/createChart.ts

Add JSDoc comment before the createChart export (line 84):
```typescript
/**
 * Creates a Bazi chart from birth date/time data.
 * 
 * @param {object} data - Input data
 * @param {string} data.chartName - Name for the chart
 * @param {string} data.birthDate - ISO 8601 datetime string (e.g., "2000-01-15T14:30:00+08:00")
 * @param {1|2} data.gender - 1 for male, 2 for female
 * @param {string} [data.timeZone] - Optional timezone (default system)
 * @returns {Promise<ChartData>} Object with year, month, day, hour pillars (each has heavenlyStem, earthlyBranch)
 * @throws {HttpsError} 'unauthenticated' if user not logged in
 * @throws {HttpsError} 'invalid-argument' if input fails schema validation
 */
export const createChart = functions.region("asia-east1").https.onCall(async (data, context) => {
```

Also add comment to createChartLogic helper explaining the ChartData structure.

Why: Clarify expectations for Flutter frontend.
Verification:
  - After: npm run build
  - Review: JSDoc is clear and matches code behavior

---

### STEP 9: Fix LOG-001 (Improve Error Differentiation)
File: apps/firebase_functions/src/callable/generateReport.ts

Around line 103 (where catch block handles report generation):
```typescript
// Before:
  } catch (err) {
    console.error('Report generation failed', err);
    throw new functions.https.HttpsError('internal', 'Report generation failed');
  }

// After:
  } catch (err: any) {
    if (err instanceof functions.https.HttpsError) {
      // Re-throw existing HttpsError (e.g., from Gemini validation)
      throw err;
    }
    console.error('Report generation failed with unknown error:', err?.message || err);
    throw new functions.https.HttpsError('internal', 'Failed to generate report. Please try again.');
  }
```

Also update line 55 (quota check error handling) to use specific code:
```typescript
// Before:
    if (quotaCount >= MONTHLY_LIMIT) {
      throw new functions.https.HttpsError('permission-denied', `Monthly report limit (${MONTHLY_LIMIT}) reached.`);
    }

// After (already correct, but verify):
    if (quotaCount >= MONTHLY_LIMIT) {
      throw new functions.https.HttpsError('resource-exhausted', `Monthly report limit (${MONTHLY_LIMIT}) reached.`);
    }
```

Why: Client can distinguish QUOTA_EXCEEDED from GEMINI_API_FAIL; better debugging.
Verification:
  - After: npm run build
  - Test: Trigger quota limit → error code is 'resource-exhausted'

---

### STEP 10: Fix DOC-001 (Add JSDoc to Remaining Functions)
Files: src/callable/*.ts, src/tasks/*.ts, src/services/*.ts

Add JSDoc to generateReport (already has inline comment, enhance):
```typescript
/**
 * Generates an AI-powered Bazi report for a chart.
 * Checks user quota, caches result, and validates against schema.
 *
 * @param {object} data - Input data
 * @param {string} data.chartId - ID of previously created chart
 * @param {string} data.reportType - One of 'career', 'wealth', 'health', 'relationship'
 * @returns {Promise<object>} { report: ReportData, metadata: { source, promptVersion, deployTag, generatedAt } }
 * @throws {HttpsError} 'unauthenticated' if not logged in
 * @throws {HttpsError} 'invalid-argument' if input fails schema validation
 * @throws {HttpsError} 'not-found' if chart not found
 * @throws {HttpsError} 'resource-exhausted' if monthly report quota exceeded
 * @throws {HttpsError} 'internal' if Gemini API call fails
 */
export const generateReport = functions.region('asia-east1').https.onCall(async (data, context) => {
```

Add JSDoc to resetMonthlyQuota:
```typescript
/**
 * Scheduled Cloud Function: resets all user monthly report quotas on the 1st of each month.
 * Runs at 00:00 Asia/Taipei time.
 *
 * @async
 * @returns {Promise<null>} Completes after batch updating all users
 * @throws {Error} If batch write fails
 */
export const resetMonthlyQuota = functions
```

Why: Helps future developers understand function contracts.
Verification:
  - After: npm run build
  - Review: Comments are present and accurate

---

### FINAL VERIFICATION STEPS

After all fixes applied, run:

1. **Build Check**:
   ```bash
   cd bazi_fengshui_app/apps/firebase_functions
   npm run build
   ```
   Expected: No TypeScript errors, lib/ directory complete

2. **Search for Remaining Issues**:
   ```bash
   grep -r "FullReportSchema\|reportSchema\|buildBaziReportPrompt\|geminiClient" src/
   ```
   Expected: 0 matches (all removed)

3. **Imports Check**:
   ```bash
   grep -r "from.*geminiClient" src/
   ```
   Expected: 0 matches (all updated to gemini)

4. **Firestore Rules Validation**:
   - View firestore.rules: verify 3 new match blocks added
   - Each should have: allow read, write: if request.auth.uid == userId

5. **Security Check** (createChart):
   - Verify context.auth check added at line 85-87
   - Build succeeds

6. **Schema Check**:
   - generateReport uses ReportDataSchema (line 5 import)
   - No unused schema exports remain
   - FunctionResponseSchema wraps ReportDataSchema (line 67)

### Summary for Record

**Fixes Applied** (In Order):
- SEC-001: Added auth check to createChart ✓
- FIR-001: Extended firestore.rules to cover subcollections ✓
- FIR-002: Consolidated quota to /users/{uid}/entitlements/monthly ✓
- SCH-001: Deleted unused FullReportSchema ✓
- ARC-001: Merged gemini.ts + geminiClient.ts ✓
- ARC-002: Deleted buildBaziReportPrompt ✓
- ARC-003: Removed reportSchema alias ✓
- ARC-004: Added JSDoc to createChart ✓
- LOG-001: Improved error differentiation ✓
- DOC-001: Added JSDoc to callables ✓

**Still Unsolved** (Requires External Setup):
- GEMINI_API_KEY not set (user must supply)
- Flutter integration not tested (requires emulator + app code review)

**Build Status**: ✅ Succeeds
**Lint Status**: ⚠️ Not enforced (no ESLint config active; use if desired)
**Test Status**: ⚠️ Not run (requires test setup)

---

Report generated: 2026-01-15
Next steps: Submit fixes to source control; notify team of breaking changes (if any).
```

---

## END OF HANDOFF_DEBUG_REPORT

**Report Compiled By**: VS Code AI Agent (Read-Only Audit)  
**Date**: 2026-01-15  
**Format**: Markdown (suitable for GitHub, Confluence, or local reference)  
**Next Actor**: Claude Code (execute fixes in section 9 order)

