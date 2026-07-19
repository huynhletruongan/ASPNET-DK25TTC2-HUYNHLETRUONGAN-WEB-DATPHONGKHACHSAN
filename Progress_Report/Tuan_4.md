BÁO CÁO TIẾN ĐỘ ĐỒ ÁN - TUẦN 4
Thời gian: 13/07/2026 - 19/07/2026  
Trọng tâm: Hiện thực hóa code chức năng quản trị (Phía Admin) và bổ sung tính năng cải tiến
1. Nội dung công việc
- Tích hợp thành công giao diện SB Admin 2 vào dự án để làm trang quản trị hệ thống Backend.
- Viết mã nguồn xử lý các chức năng CRUD (Create, Read, Update, Delete) cho các thực thể quan trọng bao gồm: Quản lý thông tin phòng khách sạn, Quản lý loại phòng, Quản lý các đơn đặt phòng của khách và Quản lý các bài viết tin tức/chính sách.
- Thiết lập giao diện cấu hình, quản lý vai trò người dùng và phân chia quyền hạn truy cập hệ thống.

2. Tài liệu liên quan
- Thư viện bảo mật ASP.NET Identity phục vụ cho xác thực người dùng.
- Cơ chế phân quyền dựa trên vai trò (Role-based Authorization) được tích hợp sẵn trong .NET để phân chia ranh giới truy cập giữa quyền Admin và quyền Khách hàng.

3. Khó khăn khi viết thêm chức năng
- Gặp trở ngại lớn và mất nhiều thời gian khi cố gắng tích hợp các chức năng nâng cao theo đề xuất cải tiến như: Thiết lập tính năng thông báo nổi (Notification) ở giao diện nhân viên khi xuất hiện đơn đặt phòng mới (theo mô hình Observer).
- Gặp khó khăn khi xây dựng logic gợi ý thông minh tự động kiểm tra sự trùng khớp thông tin liên hệ của khách hàng cũ để đưa ra đề xuất tạo mới hoặc cập nhật profile khách hàng tại trang quản trị Admin.
- Việc thử nghiệm và cấu hình môi trường truyền thông thời gian thực (Realtime) làm tiêu tốn rất nhiều thời gian xử lý cấu trúc hệ thống.

4. Kết quả đạt được
- Hoàn thiện toàn bộ hệ thống các màn hình chức năng CRUD của phân hệ Admin, đảm bảo dữ liệu cập nhật chính xác.
- Tích hợp thành công phần phân quyền cơ bản, chặn truy cập trái phép vào khu vực quản trị đối với tài khoản thông thường.
