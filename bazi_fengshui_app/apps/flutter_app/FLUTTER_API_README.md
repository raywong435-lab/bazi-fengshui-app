# Flutter API Client Implementation

## 已實作功能

### 1. **資料模型** (Freezed + JSON)

#### ChartModel
- `PillarData`: 天干地支資料
- `ChartData`: 完整四柱資料（年月日時）
- `ChartRequest`: 命盤建立請求

位置: `lib/features/charts/data/models/chart_model.dart`

#### ReportModel
- `OriginalChartAnalysis`: 原局分析
- `KeyGods`: 用神分析
- `AnnualFortune2026`: 2026 流年運勢
- `FullReport`: 完整報告

位置: `lib/features/reports/data/models/report_model.dart`

### 2. **ApiClient** - Firebase Functions 封裝

功能:
- `createChart(ChartRequest)`: 呼叫後端建立命盤
- `generateReport(String chartId)`: 呼叫後端生成報告
- 自動錯誤處理與轉換

位置: `lib/core/services/api_client.dart`

### 3. **AuthRepository** - Firebase Auth 封裝

功能:
- `signUp()`: 註冊新用戶
- `signIn()`: 登入
- `signOut()`: 登出
- `resetPassword()`: 重設密碼
- `authStateChanges`: 監聽登入狀態

位置: `lib/features/auth/data/auth_repository.dart`

## 使用範例

### 建立命盤

\`\`\`dart
final apiClient = ApiClient();

final request = ChartRequest(
  chartName: 'Ray 測試',
  birthDate: '2000-01-15T14:30:00+08:00',
  gender: 1, // 1 = male, 2 = female
  timeZone: 'Asia/Taipei',
);

final chartData = await apiClient.createChart(request);
print('年柱: ${chartData.year.heavenlyStem}${chartData.year.earthlyBranch}');
\`\`\`

### 生成報告

\`\`\`dart
final report = await apiClient.generateReport(chartId);
print(report.originalChartAnalysis.strengthAnalysis);
print(report.annualFortune2026.career);
\`\`\`

### 用戶認證

\`\`\`dart
final authRepo = AuthRepository();

// 註冊
await authRepo.signUp(
  email: 'user@example.com',
  password: 'password123',
  displayName: 'Ray',
);

// 登入
await authRepo.signIn(
  email: 'user@example.com',
  password: 'password123',
);

// 監聽狀態
authRepo.authStateChanges.listen((user) {
  if (user != null) {
    print('已登入: ${user.email}');
  }
});
\`\`\`

## 下一步：代碼生成

執行以下命令生成 Freezed 和 JSON 序列化代碼:

\`\`\`bash
cd bazi_fengshui_app/apps/flutter_app
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
\`\`\`

## 測試

示例測試頁面: `lib/screens/example_screen.dart`

集成到 app:
\`\`\`dart
// main.dart
import 'package:bazi_fengshui_app/screens/example_screen.dart';

// ...
home: BaziExampleScreen(),
\`\`\`

## API 契約對齊

✅ 前端與後端完全對齊:
- `chartName` (camelCase)
- `birthDate` (ISO 8601 datetime string)
- `gender` (number: 1 or 2)
- `timeZone` (optional string)

✅ 後端回應結構:
- `ChartData`: year/month/day/hour with heavenlyStem + earthlyBranch
- `FullReport`: originalChartAnalysis + annualFortune2026

## 注意事項

1. **代碼生成**: 修改 Freezed 模型後必須重新運行 build_runner
2. **錯誤處理**: ApiClient 已處理常見 Functions 錯誤
3. **Region**: Functions 部署在 asia-east1
4. **Emulator**: 開發環境自動連接本地 emulator (main.dart 已配置)
