# BÁO CÁO TIẾN ĐỘ ĐỒ ÁN - TUẦN 3
**Thời gian:** 06/07/2026 - 12/07/2026  
**Trọng tâm:** Hiện thực hóa code chức năng cốt lõi (Phía Khách hàng)

### 1. Nội dung công việc
- Thực hiện cấu hình chuỗi kết nối cơ sở dữ liệu (Connection String) trong file hệ thống `Web.config` bằng Entity Framework.
- Tiến hành xây dựng giao diện và viết mã nguồn xử lý logic cho phía phân hệ Khách hàng bao gồm: Màn hình trang chủ hiển thị danh sách phòng, danh mục phòng, bộ lọc tìm kiếm phòng trống theo yêu cầu.
- Phát triển logic xử lý chức năng Giỏ phòng tạm thời (thêm phòng vào danh sách chọn, điều chỉnh số lượng/thời gian lưu trú, xóa phòng khỏi danh sách).
- Hiện thực hóa chức năng Đặt phòng trực tuyến (Checkout) gửi dữ liệu lưu vào database và tính năng xem lịch sử đặt phòng của khách hàng.

### 2. Tài liệu liên quan
- Tài liệu kỹ thuật về cơ chế định tuyến ASP.NET Routing và các kiểu trả về ActionResults trong Controller.
- Cơ chế quản lý Session và Cookie trong ASP.NET nhằm phục vụ cho việc lưu trữ thông tin giỏ hàng/giỏ đặt phòng tạm thời của người dùng.

### 3. Khó khăn gặp phải
- Xử lý đồng bộ và cập nhật dữ liệu giỏ phòng một cách mượt mà khi người dùng thay đổi số lượng, thời gian trực tiếp tại giao diện front-end mà không phải tải lại toàn bộ trang web (Page Reload).
- Phải nghiên cứu áp dụng kỹ thuật AJAX kết hợp thư viện jQuery để tối ưu hóa trải nghiệm người dùng tại bước này.

### 4. Kết quả đạt được
- Vận hành ổn định toàn bộ luồng nghiệp vụ đặt phòng từ phía khách hàng: Tìm kiếm -> Chọn phòng -> Xem giỏ phòng -> Xác nhận đặt phòng -> Ghi nhận và lưu trữ đơn đặt phòng thành công vào cơ sở dữ liệu.
