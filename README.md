
**Lưu ý**: Project sử dụng flutter phiên bản `3.24.3`. Chạy `flutter pub get` trước khi làm những bước dưới

## 1. Chạy build runner để tạo các file json parse support

```bash
dart run build_runner watch --delete-conflicting-outputs
```

## 2. Setup đa ngôn ngữ

- Chạy lệnh sau để tạo file key:

```bash
dart run easy_localization:generate -S assets/translations -O lib/app/localization -o locale_keys.g.dart -f keys
```

# Code format setting

## Với VSCode

- Formatting code: Mặc định của VSCode.
- Thêm đoạn mã sau vào `.vscode/settings.json` (nếu chưa có thì tạo folder `.vscode` sau đó tạo file `settings.json`) để sắp xếp thứ tự import và format code không xuống dòng:

```json
{
   "dart.flutterSdkPath": ".fvm/flutter_sdk",
    "dart.sdkPath": ".fvm/flutter_sdk/bin/cache/dart-sdk",
    "editor.codeActionsOnSave": {
        "source.organizeImports": "always"
    },
    "editor.formatOnSave": true,
    "editor.formatOnType": true,
    "editor.selectionHighlight": false,
    "editor.suggestSelection": "first",
    "editor.tabCompletion": "onlySnippets",
    "editor.wordBasedSuggestions": "currentDocument",
    "dart.lineLength": 200,
    "dart.showDebuggerNumbersAsHex": true,
    "dart.previewFlutterUiGuides": true,
    "dart.previewHotReloadOnSaveWatcher": true,
}
```