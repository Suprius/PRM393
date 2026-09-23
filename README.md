# Lab 4 – Flutter UI Fundamentals

Hoàn thành cả 5 exercises theo đề Lab 4.

## Chạy ứng dụng

```sh
flutter pub get
flutter run
```

- Exercise 1: Text, Material Icon, Image.network, Card chứa ListTile. Ảnh cần mạng; có thông báo khi tải lỗi.
- Exercise 2: Slider 0–100, Switch, RadioListTile Action/Comedy và DatePicker. Giá trị cập nhật ngay trên màn hình; Cancel giữ nguyên ngày đã chọn.
- Exercise 3: bố cục Now Playing dùng Column, Row, Padding, SizedBox và ListView.builder; danh sách phim cuộn được trên màn hình nhỏ.
- Exercise 4: Scaffold, AppBar, FloatingActionButton và công tắc Dark đổi MaterialApp.themeMode cho toàn ứng dụng. Nút nổi hiển thị SnackBar. Theme giữ khi chuyển màn hình, trở về sáng khi khởi động lại app.
- Exercise 5: ListView trong Column dùng Expanded, SingleChildScrollView tránh overflow, bộ đếm cập nhật bằng setState và DatePicker dùng context hợp lệ.
- Màn hình chính có năm mục điều hướng tới năm bài riêng biệt.

## Mã nguồn

- `lib/main.dart`: khởi động và theme.
- `lib/ui/screens/home_page_lab4.dart`: menu bài tập.
- `lib/ui/screens/core_widgets_demo.dart`: Exercise 1.
- `lib/ui/screens/input_controls_demo.dart`: Exercise 2, StatefulWidget và setState.
- `lib/ui/screens/layout_demo.dart`: Exercise 3, bố cục và danh sách phim.
- `lib/ui/screens/app_structure_demo.dart`: Exercise 4, cấu trúc màn hình và đổi theme.
- `lib/ui/theme_controller.dart`: chia sẻ themeMode giữa các màn hình.
- `lib/ui/screens/common_ui_fixes_demo.dart`: Exercise 5, minh họa bốn cách sửa lỗi UI.
- `lib/ui/widgets/home_page_lab4_list_item.dart`: mục menu dùng lại.

## Tham khảo

Repo https://github.com/hieunhangia/PRM393, commit `a765c6f98d2b6856eb543c65b2b2c31cd2f85dd9` của hieunhangia (21/09/2026), thông điệp “bài 1 2 Lab 4”. Tham khảo menu, cách tách screen/widget và bố cục Core Widgets. Bổ sung màn hình InputControlsDemo riêng theo đề vì commit tham khảo điều hướng mọi mục tới cùng màn hình Core Widgets.

## Kiểm tra

```sh
flutter analyze --no-pub
flutter test --no-pub
```
