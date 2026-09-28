# Products – Flutter responsive catalog

## Chạy ứng dụng

```sh
flutter pub get
flutter run
```

Ứng dụng mở trực tiếp màn hình **Products**. Nút hình trường học trên AppBar mở lại các bài Lab 4 cũ.

## Đối chiếu yêu cầu

1. `lib/models/product.dart`: lớp `Product` gồm `id`, `name` (Name trong đề, dùng quy tắc đặt tên Dart), `description`, `price`, `discountPercen`, `image`. Giữ tên `discountPercen` theo đề. `discountedPrice = price * (1 - discountPercen / 100)`; hỗ trợ JSON và `copyTo`.
2. `lib/dao/product_dao.dart`: `ProductDAO.getAllProduct()` và `findProductByName(String name)`. Tìm kiếm chuỗi con, không phân biệt hoa/thường, bỏ khoảng trắng hai đầu; chuỗi rỗng trả toàn bộ danh sách. Dữ liệu mẫu lưu cục bộ.
3. `lib/ui/screens/products_page.dart`: tìm kiếm và `GridView.builder` trong `LayoutBuilder`. Số cột phụ thuộc chiều rộng widget cha và hướng màn hình từ `MediaQuery.orientationOf`.

| Chiều rộng widget cha | Dọc | Ngang |
| --- | --- | --- |
| ≤ 500 logical pixels | 1 cột | 2 cột |
| > 500 logical pixels | 2 cột | 3 cột |

Đề ghi cả ≤500 và ≥500, gây trùng tại 500. Bài triển khai chọn đúng 500 thuộc nhóm ≤500. Mỗi cột rộng `(chiều rộng cha - 24 padding - 12 * (số cột - 1)) / số cột`; không gán chiều rộng cố định cho thẻ sản phẩm. Hướng màn hình không bị thay đổi chỉ vì bàn phím chiếm chiều cao phần nội dung.

4. `lib/ui/screens/product_detail_page.dart`: chạm thẻ sản phẩm mở trang riêng hiển thị đúng ảnh, tên, mô tả và giá của sản phẩm đó; nút Back/Home quay lại danh sách và giữ từ khóa tìm kiếm. Nội dung cuộn được khi màn hình thấp.

Giao diện sử dụng AppBar xanh, ô tìm kiếm, thẻ ảnh + tên + giá gốc gạch ngang + giá giảm đỏ và nhãn phần trăm giảm theo bố cục ảnh tham khảo. Dữ liệu/giá là mẫu cho bài tập; giá giảm tính theo phần trăm, hiển thị hai chữ số thập phân. Có giỏ hàng trong bộ nhớ: thêm, xem, xóa và tính tổng; khởi động lại sẽ xóa giỏ hàng.

## Ảnh sản phẩm

Ảnh WebP được đóng gói tại `assets/products/`, khai báo trong `pubspec.yaml`, không cần mạng khi chạy. Tên sản phẩm mẫu khớp với ảnh dùng: iPhone 13 Pro, Samsung Galaxy S10, MacBook Pro.

Nguồn ảnh mẫu: [DummyJSON](https://dummyjson.com/).

- https://cdn.dummyjson.com/product-images/smartphones/iphone-13-pro/1.webp
- https://cdn.dummyjson.com/product-images/smartphones/samsung-galaxy-s10/1.webp
- https://cdn.dummyjson.com/product-images/laptops/apple-macbook-pro-14-inch-space-grey/1.webp

## Kiểm tra

```sh
flutter analyze
flutter test
```

`test/products_test.dart` kiểm tra model, tìm kiếm, 9 kích thước/hướng màn hình (bao gồm 499/500/501), chiều rộng widget cha, trang chi tiết của từng sản phẩm, giữ tìm kiếm khi quay lại, giỏ hàng và màn hình nhỏ với chữ lớn. `test/widget_test.dart` giữ kiểm tra các bài Lab 4 qua lối vào mới.
