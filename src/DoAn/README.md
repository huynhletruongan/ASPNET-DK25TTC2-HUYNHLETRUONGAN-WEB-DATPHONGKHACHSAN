# Hệ Thống Quản Lý Khách Sạn - An-Huynh

## Giới thiệu

Đồ án môn học **Hệ Thống Thông Tin** - Quản lý khách sạn với đầy đủ chức năng: đặt phòng, thuê phòng, quản lý nhân viên, dịch vụ, hóa đơn và phân quyền.

## Công nghệ sử dụng

- **Framework:** ASP.NET MVC 5 (.NET Framework 4.7.2)
- **ORM:** Entity Framework 6 (Database First)
- **Database:** SQLite (mặc định) / SQL Server
- **Frontend:** Bootstrap 4, SB Admin 2, Font Awesome 6
- **Authentication:** Forms Authentication

## Cấu trúc dự án

```
DoAn/
├── App_Start/          # Cấu hình ứng dụng (Bundle, Route, Filter)
├── Assets/             # CSS, JS, hình ảnh giao diện
├── Common/             # Các class dùng chung (Encryptor, Constants, Attributes)
├── Controllers/        # Các Controller xử lý nghiệp vụ
├── Models/             # Entity Framework models và DbContext
├── Views/              # Razor Views
├── Web.config          # Cấu hình ứng dụng
└── Global.asax.cs      # Entry point
```

## Tính năng chính

### Quản lý người dùng & Phân quyền
- Đăng nhập/Đăng xuất với Forms Authentication
- 3 nhóm người dùng: **Quản lý (QL)**, **Lễ tân (LT)**, **Dịch vụ (DV)**
- Phân quyền chi tiết theo chức năng

### Quản lý Phòng
- Loại phòng (Standard, Deluxe, Suite, VIP)
- Trạng thái phòng (Trống / Đang sử dụng)
- Tìm kiếm theo trạng thái và loại phòng

### Quản lý Đặt phòng & Thuê phòng
- Phiếu đặt phòng (PDP)
- Phiếu thuê phòng (PTP)
- Chi tiết đặt/thuê phòng

### Dịch vụ & Hóa đơn
- Mini bar, giặt ủi, spa, bữa sáng buffet...
- Tính tiền tự động theo ngày thuê
- Hỗ trợ thanh toán

### Thống kê & Báo cáo
- Thống kê doanh thu theo dịch vụ
- Theo dõi phiếu đặt, phiếu thuê chưa xử lý

## Tài khoản mặc định

| Username   | Password | Nhóm     | Quyền |
|------------|----------|----------|-------|
| admin      | 123      | Quản lý  | Toàn bộ |
| letan1     | 123      | Lễ tân   | Lễ tân |
| letan2     | 123      | Lễ tân   | Lễ tân |
| dichvu1    | 123      | Dịch vụ  | Dịch vụ |

## Cấu hình Database

### SQLite (Mặc định)
- Database tự động được tạo tại `~/database/app.db`
- Khởi tạo schema và dữ liệu mẫu tự động khi chạy ứng dụng
- **Không cần cài đặt thêm**

### SQL Server
1. Mở `Web.config`, chỉnh sửa connection string `DoAnEntities`:
   ```xml
   <add name="DoAnEntities" connectionString="metadata=...;provider=System.Data.SqlClient;provider connection string=&quot;data source=YOUR_SERVER;initial catalog=DoAn;integrated security=True;MultipleActiveResultSets=True;App=EntityFramework&quot;" providerName="System.Data.EntityClient" />
   ```
2. Đổi `DatabaseProvider` trong `appSettings`:
   ```xml
   <add key="DatabaseProvider" value="SqlServer" />
   ```
3. Chạy script SQL tạo database (thực thi từ file EDMX hoặc migrate)

## Chạy ứng dụng

### Visual Studio
1. Mở solution `DoAn.sln` bằng Visual Studio
2. Build project (Ctrl+Shift+B)
3. Nhấn F5 để chạy
4. Truy cập `http://localhost:xxxxx/Login` để đăng nhập

### IIS
1. Publish project ra thư mục
2. Cấu hình IIS Application Pool (Enable 32-bit if needed)
3. Đảm bảo thư mục `database` có quyền ghi cho IIS

## Cấu trúc Database

### Các bảng chính

- **LoaiPhong** - Loại phòng (LP01-LP04)
- **Phong** - Danh sách phòng (P101, P102, ...)
- **NhomNhanVien** - Nhóm nhân viên (QL, LT, DV)
- **NhanVien** - Thông tin nhân viên
- **Quyen** - Danh sách quyền
- **DanhSachQuyen** - Phân quyền cho nhóm
- **QuanTri** - Tài khoản đăng nhập
- **KhachHang** - Thông tin khách hàng
- **DichVu** - Dịch vụ khách sạn
- **PhieuDatPhong** - Phiếu đặt phòng
- **CTPhieuDatPhong** - Chi tiết đặt phòng
- **PhieuThuePhong** - Phiếu thuê phòng
- **CTPhieuThuePhong** - Chi tiết thuê phòng + dịch vụ
- **HoaDon** - Hóa đơn thanh toán
- **LienHe** - Liên hệ từ website
- **PhanHoi** - Phản hồi khách hàng

## Liên hệ

- An-Huynh - Đồ án Hệ Thống Thông Tin
