# Project Clone và Rename từ bloc_rxdart

Hướng dẫn chi tiết cách clone và rename project từ template bloc_rxdart.

## Các bước thực hiện

### 1. Clone Repository
```bash
git clone https://github.com/Cat1m/bloc_rxdart.git
cd bloc_rxdart
```

### 2. Cài đặt package rename
Thêm vào `pubspec.yaml`:
```yaml
dev_dependencies:
  rename: ^3.0.2
```

Sau đó chạy:
```bash
flutter pub get
```

### 3. Rename Project

#### 3.1. Kiểm tra tên hiện tại
```bash
# Kiểm tra tên app
dart run rename getAppName --targets android,ios

# Kiểm tra bundle ID
dart run rename getBundleId --targets android,ios
```

#### 3.2. Đổi tên app và bundle ID
```bash
# Đổi tên app
dart run rename setAppName --targets android,ios --value "Tên App Mới"

# Đổi bundle ID
dart run rename setBundleId --targets android,ios --value com.yourcompany.app_name
```

### 4. Thay thế các đường dẫn import

#### 4.1. Sử dụng VS Code
- Mở Search (Ctrl + Shift + F hoặc Cmd + Shift + F)
- Tìm: `package:bloc_rxdart`
- Thay thế: `package:tên_app_mới`
- Chọn Replace All

#### 4.2. Hoặc sử dụng Terminal
```bash
find . -type f -name "*.dart" -exec sed -i 's/package:bloc_rxdart/package:tên_app_mới/g' {} +
```

### 5. Cập nhật pubspec.yaml
```yaml
name: tên_app_mới
description: Mô tả app của bạn
```

### 6. Dọn dẹp và cập nhật project
```bash
# Dọn dẹp cache
flutter clean

# Cập nhật dependencies
flutter pub get
```

### 7. Tạo Repository mới
```bash
# Xóa liên kết git cũ
rm -rf .git

# Khởi tạo git mới
git init

# Thêm remote mới
git remote add origin https://github.com/username/new-repo-name.git

# Commit và push
git add .
git commit -m "Initial commit"
git branch -M main
git push -u origin main
```

## Cấu trúc Project

```
lib/
├── src/
│   ├── config/
│   ├── data/
│   ├── domain/
│   ├── presentation/
│   └── utils/
```

## Dependencies

- rename: ^3.0.2
- [Các dependencies khác trong project]

## Chú ý

- Đảm bảo kiểm tra kỹ các file import sau khi rename
- Test app trên cả Android và iOS sau khi rename
- Kiểm tra các cấu hình trong:
  - android/app/build.gradle
  - ios/Runner.xcodeproj/project.pbxproj
  - ios/Runner/Info.plist

## Troubleshooting

Nếu gặp lỗi với rename tool trên Windows, thử sử dụng:
```bash
flutter pub run rename <command> [arguments]
# hoặc
dart run rename <command> [arguments]
```

## License

[Loại license của project]
