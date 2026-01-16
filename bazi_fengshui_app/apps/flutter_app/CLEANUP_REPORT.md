# 代碼清理報告

**清理時間**: 2026-01-16 11:50:01

## 已刪除的項目

1. **重複目錄**: 
   - bazi-fengshui-app/ (舊結構)

2. **備份文件**:
   - firebase.json.bak

3. **日誌文件**:
   - emulog.txt
   - firebase-debug.log
   - firestore-debug.log
   - bazi_fengshui_app/emulog.txt

4. **構建緩存** (~180 MB):
   - .dart_tool/
   - build/

## 磁盤空間節省

- **釋放空間**: ~180.47 MB

## 當前項目結構

 **活躍代碼**:
- bazi_fengshui_app/apps/flutter_app/
- bazi_fengshui_app/apps/firebase_functions/
- bazi_fengshui_app/packages/

 **配置文件**:
- firebase.json (根目錄)
- melos.yaml
- .firebaserc

## 下一步

構建緩存會在下次運行時自動重新生成：
\\\powershell
cd bazi_fengshui_app/apps/flutter_app
flutter pub get
flutter pub run build_runner build
\\\

