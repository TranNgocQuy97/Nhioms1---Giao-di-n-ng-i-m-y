### Lingua Master App

## Giới thiệu
Multi-Language Learning App là ứng dụng học ngôn ngữ hỗ trợ người dùng học các ngôn ngữ phổ biến như Tiếng Anh, Tiếng Trung, Tiếng Hàn và Tiếng Nhật. Ứng dụng cung cấp các bài học từ vựng, ngữ pháp và bài tập tương tác nhằm giúp người học rèn luyện toàn diện kỹ năng ngôn ngữ. Ngoài ra, hệ thống còn tích hợp tính năng gamification với điểm thưởng, huy hiệu và bảng xếp hạng để tăng động lực cho người học.

## Tính năng chính
# Phần Người dùng (User App - Flutter)
- Đăng ký và đăng nhập: Cho phép người dùng tạo tài khoản mới hoặc đăng nhập bằng email/số điện thoại.
- Quản lý tài khoản: Người dùng có thể xem và chỉnh sửa thông tin cá nhân, bao gồm tên, ảnh đại diện, và thành tích học tập.
- Chọn khóa học: Người dùng có thể chọn ngôn ngữ và khóa học phù hợp với trình độ (cơ bản, trung cấp, nâng cao).
- Làm bài tập: Cung cấp các bài tập thực hành như trắc nghiệm, điền từ, ghép từ để kiểm tra khả năng của người học.
- Gamification: Tích lũy điểm thưởng, huy hiệu và xếp hạng trong bảng thành tích để tăng động lực học tập.
- Gửi phản hồi: Người dùng có thể gửi phản hồi về bài học hoặc báo lỗi cho quản trị viên.

# Phần Quản trị (Admin Panel - PHP)
- Quản lý người dùng: Admin có thể xem danh sách người dùng, tìm kiếm, chỉnh sửa thông tin và khóa/mở tài khoản.
- Quản lý khóa học: Tạo, chỉnh sửa, xóa và phân loại các khóa học theo ngôn ngữ và cấp độ.
- Quản lý phản hồi và lỗi: Xem và xử lý phản hồi từ người dùng, kiểm tra và xử lý lỗi hệ thống.
- Báo cáo tiến trình học tập: Xem báo cáo tổng quan về tiến trình học tập của người dùng, bao gồm thời gian học và điểm số.

## Cài đặt
# Phần User App (Flutter)
Yêu cầu hệ thống
- Flutter SDK: 2.5 trở lên
- Dart: 2.12 trở lên
- Android Studio hoặc Xcode (nếu muốn chạy trên Android/iOS simulator)
Cài đặt
# Clone repository
git clone https://github.com/yourusername/multi-language-learning-app.git

# Điều hướng đến thư mục của ứng dụng Flutter
cd multi-language-learning-app/user_app

# Cài đặt dependencies
flutter pub get

# Chạy ứng dụng
flutter run

# Phần Admin Panel (PHP)
Yêu cầu hệ thống
- PHP: 7.3 trở lên
- MySQL: 5.7 trở lên
- Web Server: Apache hoặc Nginx
Cài đặt
# Clone repository 
git clone https://github.com/yourusername/multi-language-learning-app.git

# Điều hướng đến thư mục của Admin Panel:
cd multi-language-learning-app/admin_panel

# Cấu hình cơ sở dữ liệu:
- Tạo một cơ sở dữ liệu MySQL cho ứng dụng và nhập file SQL có sẵn (database.sql) để tạo bảng dữ liệu.
- Cập nhật thông tin cấu hình cơ sở dữ liệu trong file config.php.

# Chạy ứng dụng trên server:
- Khởi động server và truy cập vào đường dẫn http://localhost/admin_panel để sử dụng giao diện quản trị.

## Công nghệ sử dụng
# Flutter: Phát triển ứng dụng di động đa nền tảng cho người dùng.
# PHP và MySQL: Xây dựng backend API và Admin Panel để quản lý dữ liệu.
# Dart: Ngôn ngữ lập trình cho ứng dụng Flutter.

## Tính năng cần phát triển thêm
# Tích hợp đa ngôn ngữ: Hỗ trợ nhiều ngôn ngữ cho giao diện người dùng.
# Thông báo đẩy (Push Notification): Gửi thông báo về tiến trình học và điểm thưởng.

## Đóng góp
Chào đón mọi đóng góp từ cộng đồng để làm cho ứng dụng trở nên tốt hơn! Nếu bạn muốn đóng góp, vui lòng fork repo này, tạo một nhánh mới, commit và gửi pull request.

## Liên hệ
# Email: yangan1910@gmail.com
