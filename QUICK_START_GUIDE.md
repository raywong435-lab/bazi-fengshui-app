# 快速啟動指南

## 🚀 一鍵啟動測試環境

### 方法 1：自動化啟動 (推薦)

打開兩個 PowerShell 終端視窗：

**終端 1 - Firebase Emulator:**
```powershell
cd bazi_fengshui_app\apps\firebase_functions
npm run build
cd ..\..\..
firebase emulators:start --only auth,firestore,functions
```

**終端 2 - Flutter 應用:**
```powershell
cd bazi_fengshui_app\apps\flutter_app
flutter run
```

---

### 方法 2：分步啟動

#### 步驟 1：編譯 TypeScript Functions
```powershell
cd bazi_fengshui_app\apps\firebase_functions
npm run build
```

應該看到：
```
> firebase_functions@1.0.0 build
> npm run clean && tsc

✓ TypeScript compiled successfully
```

#### 步驟 2：啟動 Firebase Emulator
```powershell
cd ..\..\..
firebase emulators:start --only auth,firestore,functions
```

應該看到：
```
┌─────────────┬────────────────┐
│  Emulator   │ Host:Port      │
├─────────────┼────────────────┤
│ Auth        │ localhost:9099 │
│ Functions   │ localhost:5001 │
│ Firestore   │ localhost:8080 │
└─────────────┴────────────────┘

✔ All emulators ready!
```

#### 步驟 3：運行 Flutter 應用
```powershell
# 在新的終端視窗
cd bazi_fengshui_app\apps\flutter_app
flutter run
```

選擇設備：
- `1` - Windows 桌面應用
- `2` - Chrome 瀏覽器
- `3` - Edge 瀏覽器
- 或連接 Android/iOS 設備

---

## 🧪 測試流程

### 1. 註冊新用戶
1. 啟動應用後會看到登入/註冊畫面
2. 點擊底部「沒有帳戶？立即註冊」
3. 輸入：
   - 姓名：`測試用戶`
   - 電子郵件：`test@example.com`
   - 密碼：`password123`
4. 點擊「註冊」
5. 成功後會自動跳轉到首頁

### 2. 生成八字命盤
1. 在首頁填寫：
   - 姓名：`張三`
   - 出生日期：點擊選擇 `2000-01-15`
   - 出生時間：點擊選擇 `14:30`
   - 性別：選擇 `男性`
2. 點擊「生成八字命盤」
3. 等待 API 調用完成（約 2-3 秒）
4. 看到成功提示「八字命盤生成成功！」

### 3. 查看 Emulator 日誌
在 Firebase Emulator 終端視窗，你應該看到：
```
>  {
     "chartName": "張三",
     "birthDate": "2000-01-15T14:30:00.000+08:00",
     "gender": 1,
     "timeZone": "Asia/Taipei"
   }

<  {
     "year": { "heavenlyStem": "庚", "earthlyBranch": "辰" },
     "month": { "heavenlyStem": "丁", "earthlyBranch": "丑" },
     "day": { "heavenlyStem": "...", "earthlyBranch": "..." },
     "hour": { "heavenlyStem": "...", "earthlyBranch": "..." }
   }
```

---

## 🔧 故障排除

### 問題 1: "找不到路徑"
**解決方案**: 確保你在正確的目錄
```powershell
cd C:\Users\raywo\Downloads\bazi-fengshui-app
pwd  # 確認當前目錄
```

### 問題 2: "Port already in use"
**解決方案**: 關閉占用端口的進程
```powershell
netstat -ano | findstr :5001
taskkill /PID <進程ID> /F
```

### 問題 3: "Firebase Emulator 連接失敗"
**解決方案**: 檢查 Emulator 是否運行
```powershell
# 訪問 Emulator UI
start http://localhost:4000
```

### 問題 4: "Flutter 編譯錯誤"
**解決方案**: 清理並重新生成代碼
```powershell
cd bazi_fengshui_app\apps\flutter_app
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

---

## 📱 支援的平台

✅ **已測試**:
- Windows 桌面應用
- Web (Chrome/Edge)

⏳ **待測試**:
- Android 模擬器
- iOS 模擬器

---

## 📊 驗證清單

測試完成後，確認以下功能正常：

- [ ] 用戶可以註冊新帳戶
- [ ] 用戶可以登入
- [ ] 登入後自動跳轉到首頁
- [ ] 表單驗證正常（空值、無效郵件等）
- [ ] DatePicker 和 TimePicker 正常工作
- [ ] 性別選擇器正常
- [ ] 點擊「生成八字命盤」後顯示加載指示符
- [ ] API 調用成功後顯示綠色成功提示
- [ ] API 調用失敗時顯示紅色錯誤提示
- [ ] Firebase Emulator 日誌顯示請求和響應

---

## 🎯 下一步

功能測試完成後，可以：

1. **查看實施報告**: [IMPLEMENTATION_REPORT_PHASE_A.md](./IMPLEMENTATION_REPORT_PHASE_A.md)
2. **繼續開發報告顯示功能**
3. **開始方案 B - 代碼優化**

有任何問題，隨時告訴我！🚀
