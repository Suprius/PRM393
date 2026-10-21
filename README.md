# Products App

Ứng dụng Flutter hiển thị danh sách sản phẩm, tìm kiếm theo tên và xem thông tin chi tiết.

## Chức năng

- Hiển thị ảnh, tên, giá gốc và giá sau giảm của sản phẩm.
- Tìm kiếm sản phẩm theo tên.
- Tự điều chỉnh số cột theo kích thước và hướng màn hình.
- Xem ảnh, tên và mô tả trên trang chi tiết.
- Màn hình Cart riêng, tách `CartItemWidget` và `CartWidget` để tái sử dụng.
- Thêm sản phẩm, gộp sản phẩm trùng, tăng/giảm số lượng, xóa từng món hoặc toàn bộ giỏ.
- Tự cập nhật badge số lượng, tổng giá gốc, tiền tiết kiệm và tổng sau giảm giá.
- Xác nhận đơn hàng demo (không thực hiện thanh toán thật).
- Riverpod quản lý giỏ hàng dùng chung giữa các màn hình trong phiên chạy app.
  Giỏ hàng chưa được lưu sau khi đóng/khởi động lại ứng dụng.

## Chạy ứng dụng

```sh
flutter pub get
dart run build_runner build
flutter run
```

## Kiểm tra

```sh
flutter analyze
flutter test
```

## Cấu trúc giỏ hàng

- `lib/models/cart_item.dart`: sản phẩm, số lượng và thành tiền mỗi dòng.
- `lib/models/cart.dart`: danh sách bất biến và các tổng tiền tính bằng cent.
- `lib/providers/cart_provider.dart`: Riverpod notifier, sinh mã bằng
  `riverpod_annotation` + `riverpod_generator` + `build_runner`.
- `lib/ui/screens/cart_page.dart`: màn hình, xác nhận xóa và đặt đơn demo.
- `lib/ui/widgets/cart_item_widget.dart`: giao diện mỗi sản phẩm trong giỏ.
- `lib/ui/widgets/cart_widget.dart`: danh sách, trạng thái rỗng và tổng đơn hàng.

Sau khi sửa annotation/provider, chạy lại `dart run build_runner build`.
