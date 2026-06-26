# Hệ Thống Quản Lý Khách Sạn - An-Huynh

> Đồ án môn học **Hệ Thống Thông Tin** — Quản lý khách sạn toàn diện.

---

## Mục lục

1. [Giới thiệu](#1-giới-thiệu)
2. [Tính năng](#2-tính-năng)
3. [Tài khoản mặc định](#3-tài-khoản-mặc-định)
4. [Đường dẫn trang quản trị](#4-đường-dẫn-trang-quản-trị)
5. [Cấu trúc dự án](#5-cấu-trúc-dự-án)
6. [Cài đặt & Chạy](#6-cài-đặt--chạy)
7. [Sơ đồ Database](#7-sơ-đồ-database)
8. [Lỗi thường gặp & Cách xử lý](#8-lỗi-thường-gặp--cách-xử-lý)

---

## 1. Giới thiệu

**Hệ Thống Quản Lý Khách Sạn** là phần mềm quản lý khách sạn được phát triển bằng **ASP.NET MVC 5**, hỗ trợ đầy đủ quy trình từ đặt phòng, thuê phòng, sử dụng dịch vụ đến xuất hóa đơn. Hệ thống gồm hai phần chính:

- **Trang khách sạn công khai** — trang landing page công khai cho khách hàng xem thông tin, đặt phòng, gửi liên hệ và phản hồi.
- **Trang quản trị (Admin)** — trang quản lý nội bộ dành cho nhân viên và quản trị viên quản lý toàn bộ hoạt động khách sạn.

### Công nghệ sử dụng

| Lớp | Công nghệ |
|---|---|
| Backend | ASP.NET MVC 5 (.NET Framework 4.7.2), C# |
| ORM | Entity Framework 6 (Database First / EDMX) |
| Database | SQLite (mặc định) hoặc SQL Server Express |
| Authentication | Forms Authentication (cookie-based, MD5) |
| Giao diện Admin | SB Admin 2, Bootstrap 4, Font Awesome 6, jQuery DataTables, Chart.js |
| Giao diện Khách hàng | Bootstrap 3, giao diện responsive |
| Runtime | IIS / IIS Express / Visual Studio |

---

## 2. Tính năng

### 2.1. Trang công khai (Không cần đăng nhập)

| Tính năng | Mô tả |
|---|---|
| Trang chủ khách sạn | Landing page với giới thiệu, hình ảnh, dịch vụ, đội ngũ, đánh giá khách |
| Đặt phòng | Form đặt phòng — tạo Phiếu đặt phòng (PDP) và Khách hàng mới |
| Liên hệ | Form gửi liên hệ cho ban quản lý |
| Phản hồi | Form gửi phản hồi/đánh giá dịch vụ |

### 2.2. Trang quản trị (Yêu cầu đăng nhập)

#### Quản lý Phòng

| Tính năng | Mô tả |
|---|---|
| Quản lý Loại phòng | CRUD loại phòng (Standard, Deluxe, Suite, VIP), tải lên ảnh, đặt giá |
| Quản lý Phòng | CRUD phòng (P101–P303), cập nhật trạng thái Trống / Đang sử dụng, tìm kiếm theo loại/trạng thái |

#### Quản lý Đặt phòng & Thuê phòng

| Tính năng | Mô tả |
|---|---|
| Phiếu đặt phòng | CRUD phiếu đặt phòng + chi tiết phòng đặt + tiền cọc |
| Phiếu thuê phòng | CRUD phiếu thuê phòng (từ đặt phòng → thuê), gắn phòng + dịch vụ sử dụng |
| Kiểm tra phòng trống | Tra cứu phòng trống theo khoảng ngày |

#### Quản lý Dịch vụ & Hóa đơn

| Tính năng | Mô tả |
|---|---|
| Quản lý Dịch vụ | CRUD dịch vụ (bữa sáng, ăn trưa, mini bar, giặt ủi, nước uống...) |
| Tính tiền tự động | Tiền phòng = đơn giá × số ngày + dịch vụ sử dụng − tiền cọc |
| Quản lý Hóa đơn | Xuất hóa đơn, xem chi tiết thanh toán |

#### Quản lý Nhân sự & Phân quyền

| Tính năng | Mô tả |
|---|---|
| Quản lý Nhân viên | CRUD nhân viên, tải lên ảnh đại diện, tìm kiếm theo nhóm |
| Quản lý Nhóm nhân viên | CRUD nhóm: ADMIN (Quản trị), NHANVIEN (Nhân viên) |
| Phân quyền | Gán quyền cho từng nhóm (thêm khách, sửa phòng, lập hóa đơn...) |
| Quản lý Tài khoản | CRUD tài khoản đăng nhập, đổi mật khẩu, lưu MD5 |

#### Thống kê & Tiếp nhận

| Tính năng | Mô tả |
|---|---|
| Dashboard | Tổng quan: phiếu đặt/thuê chưa xử lý, liên hệ/phản hồi chưa đọc |
| Thống kê doanh thu | Thống kê doanh thu theo dịch vụ, lọc theo khoảng ngày |
| Quản lý Liên hệ | Xem, đánh dấu đã đọc, xóa liên hệ |
| Quản lý Phản hồi | Xem, đánh dấu đã đọc, xóa phản hồi |

---

## 3. Tài khoản mặc định

> **Lưu ý:** Tất cả mật khẩu mặc định là `123`.

| Username | Password | Nhóm | Tên nhân viên |
|---|---|---|---|
| `admin` | `123` | **ADMIN** | Phan Thanh Ha |
| `user1` | `123` | NHANVIEN | Phan Thanh Ha |

Nhóm **ADMIN** có toàn quyền truy cập mọi chức năng quản trị (bypass toàn bộ kiểm tra quyền).

---

## 4. Đường dẫn trang quản trị

### Trang công khai

| Đường dẫn | Mô tả |
|---|---|
| `/Hotel` hoặc `/` | Trang chủ khách sạn |
| `/Hotel/DatPhong?maphong=P101` | Form đặt phòng |
| `/Hotel/LienHe` | Form liên hệ |
| `/Hotel/PhanHoi` | Form phản hồi |

### Trang quản trị (yêu cầu đăng nhập)

| Đường dẫn | Mô tả |
|---|---|
| `/Login` hoặc `/Login/Index` | Trang đăng nhập |
| `/Home` hoặc `/Home/Index` | Dashboard quản trị |
| `/Phongs` | Quản lý phòng |
| `/LoaiPhongs` | Quản lý loại phòng |
| `/DichVus` | Quản lý dịch vụ |
| `/PhieuDatPhongs` | Quản lý phiếu đặt phòng |
| `/PhieuThuePhongs` | Quản lý phiếu thuê phòng |
| `/HoaDons` | Quản lý hóa đơn |
| `/KiemTraPhongTrong` | Kiểm tra phòng trống |
| `/KhachHangs` | Quản lý khách hàng |
| `/NhanViens` | Quản lý nhân viên |
| `/NhomNhanViens` | Quản lý nhóm nhân viên |
| `/QuanTris` hoặc `/Quantris` | Quản lý tài khoản |
| `/DanhSachQuyens` | Phân quyền nhóm |
| `/ThongKe/ByDichVu` | Thống kê doanh thu |
| `/ThongTinTaiKhoan` | Thông tin tài khoản cá nhân |
| `/ThongTinTaiKhoan/DoiMatKhau` | Đổi mật khẩu |
| `/LienHes` | Quản lý liên hệ |
| `/PhanHois` | Quản lý phản hồi |

---

## 5. Cấu trúc dự án

```
bookkhachsan/
│
├── Setup.bat                    # Trình cài đặt tự động (IIS + DB + Build)
├── SQL_DoAn.sql                 # Script khởi tạo database SQL Server
│
└── src/DoAn/
    ├── DoAn.sln                 # Visual Studio Solution
    ├── DoAn.csproj              # Project file
    ├── Web.config               # Cấu hình ứng dụng, DB, Auth
    ├── Global.asax(.cs)          # Entry point — đăng ký route, filter, DB init
    │
    ├── App_Start/
    │   ├── RouteConfig.cs       # Cấu hình URL routing
    │   ├── BundleConfig.cs      # Bundle CSS/JS
    │   └── FilterConfig.cs      # Global filters
    │
    ├── Assets/
    │   ├── Admin/               # Giao diện SB Admin 2 (Bootstrap 4)
    │   │   ├── css/
    │   │   ├── js/
    │   │   ├── scss/
    │   │   └── vendor/          # Bootstrap, Font Awesome, Chart.js, DataTables, jQuery
    │   └── Client/              # Giao diện trang công khai
    │       ├── css/
    │       ├── js/
    │       ├── fonts/
    │       └── images/
    │
    ├── Common/                  # Class dùng chung
    │   ├── CommonConstants.cs    # Keys: USER_SESSION, ADMIN_GROUP...
    │   ├── Encryptor.cs         # Hàm băm MD5
    │   ├── HasCredentialAttribute.cs  # Attribute phân quyền
    │   └── UserLogin.cs         # Model session người dùng
    │
    ├── Controllers/             # 20 controllers MVC
    │   ├── BaseController.cs    # Lớp base — kiểm tra đăng nhập
    │   ├── LoginController.cs   # Đăng nhập / Đăng xuất
    │   ├── HotelController.cs   # Trang công khai
    │   ├── HomeController.cs    # Dashboard
    │   ├── PhongsController.cs
    │   ├── LoaiPhongsController.cs
    │   ├── DichVusController.cs
    │   ├── PhieuDatPhongsController.cs
    │   ├── PhieuThuePhongsController.cs
    │   ├── HoaDonsController.cs
    │   ├── KiemTraPhongTrongController.cs
    │   ├── KhachHangsController.cs
    │   ├── NhanViensController.cs
    │   ├── NhomNhanViensController.cs
    │   ├── QuanTrisController.cs
    │   ├── DanhSachQuyensController.cs
    │   ├── ThongKeController.cs
    │   ├── ThongTinTaiKhoanController.cs
    │   ├── LienHesController.cs
    │   └── PhanHoisController.cs
    │
    ├── Models/                  # Entity Framework models + EDMX
    │   ├── DoAn.Context.cs
    │   ├── DoAn.Designer.cs
    │   ├── DoAn.edmx            # Entity Data Model (Database First)
    │   ├── DoAn.edmx.diagram
    │   └── *.cs                 # Entity classes (Phong, KhachHang, HoaDon...)
    │
    ├── Views/                   # 88 Razor views (.cshtml)
    │   ├── Shared/              # Layout, _401, _404...
    │   ├── Login/
    │   ├── Hotel/
    │   ├── Home/
    │   ├── Phongs/
    │   ├── LoaiPhongs/
    │   └── ... (tương ứng Controllers)
    │
    └── Images/                  # Ảnh phòng, ảnh nhân viên tải lên
```

---

## 6. Cài đặt & Chạy

### Cách 1: Chạy Setup.bat (Khuyến nghị — Windows)

```batch
# Tại thư mục gốc dự án (chứa Setup.bat)
.\Setup.bat
```

Wizard sẽ hỏi:
1. Chọn database provider (SQLite khuyến nghị / SQL Server Express)
2. Cấu hình Web.config tự động
3. Build project
4. Đăng ký IIS site trên port `49851`
5. Mở trình duyệt → `/Login`

Sau khi hoàn tất, truy cập:
- **Quản trị:** `http://localhost:49851/Login`
- **Trang công khai:** `http://localhost:49851/Hotel`

### Cách 2: Visual Studio

1. Mở `DoAn.sln` bằng Visual Studio
2. Build (Ctrl+Shift+B)
3. Nhấn F5 để chạy
4. Truy cập `/Login` để đăng nhập quản trị

### Cách 3: IIS thủ công

1. Publish project ra thư mục (File → Publish)
2. Mở **IIS Manager** → tạo Application Pool (.NET v4.0, Enable 32-bit nếu cần)
3. Tạo Website trỏ đến thư mục publish
4. Đảm bảo thư mục `database` có quyền ghi cho IIS

### Chuyển đổi Database

| Provider | Cách chuyển |
|---|---|
| SQLite → SQL Server | Đổi `DatabaseProvider` = `SqlServer` trong `Web.config` |
| SQL Server → SQLite | Đổi `DatabaseProvider` = `SQLite` trong `Web.config` |

---

## 7. Sơ đồ Database

```
LoaiPhong (maLP) ────< Phong (maP)
                            │
NhomNhanVien (IDNhom) ────< QuanTri (username)      ────> NhanVien (maNV)
                            │                              │
NhomNhanVien (IDNhom) ────< DanhSachQuyen ────> Quyen (IDQuyen)
                                                      │
KhachHang (maKH) ────< PhieuDatPhong (maPDP)
                              │
NhanVien (maNV) ────< PhieuDatPhong (maPDP)
                              │
                              └──< CTPhieuDatPhong >───┤ Phong (maP)
                                    (maPDP, maP)
                                    + soTienCoc

PhieuDatPhong (maPDP) ───> PhieuThuePhong (maPTP)
                                   │
NhanVien (maNV) ────────────────────┤
KhachHang (maKH) ──────────────────┤
                                   │
                                   └──< CTPhieuThuePhong >── Phong (maP)
                                         (maPTP, maP, ngaySD, maDV)
                                                                        │
                                                                        └──< DichVu (maDV)

PhieuThuePhong (maPTP) ────> HoaDon (maPTP)
                                   │
NhanVien (maNV) ────────────────────┤

LienHe (id)           — Liên hệ từ website (công khai)
PhanHoi (id)          — Phản hồi từ website (công khai)
```

### Mô tả các bảng

| Bảng | Khóa chính | Mô tả |
|---|---|---|
| `LoaiPhong` | `maLP` | Loại phòng (SGL, DBL, TWN, TRPL1, TRPL2) — giá, ảnh |
| `Phong` | `maP` | Phòng (P101–P303) — FK `maLP`, trạng thái |
| `NhomNhanVien` | `IDNhom` | Nhóm: ADMIN, NHANVIEN |
| `NhanVien` | `maNV` | Nhân viên (NV0001: Phan Thanh Ha, NV0002: Duong Ngoc Thoai) |
| `Quyen` | `IDQuyen` | 10 quyền: ADD_CUSTOMER, EDIT_USER, LAPHOADON... |
| `DanhSachQuyen` | `(IDNhom, IDQuyen)` | Gán quyền cho nhóm |
| `QuanTri` | `username` | Tài khoản đăng nhập — MD5 password, FK `maNV`, `IDNhom` |
| `KhachHang` | `maKH` | Khách hàng (14 khách mẫu) |
| `DichVu` | `maDV` | Dịch vụ (bữa sáng, ăn trưa, cola, giặt ủi, nước) |
| `PhieuDatPhong` | `maPDP` | Phiếu đặt phòng — FK `maKH`, `maNV`, ngày đặt |
| `CTPhieuDatPhong` | `(maPDP, maP)` | Chi tiết đặt phòng + tiền cọc |
| `PhieuThuePhong` | `maPTP` | Phiếu thuê phòng — FK `maPDP`, `maKH`, `maNV`, ngày thuê |
| `CTPhieuThuePhong` | `(maPTP, maP, ngaySD, maDV)` | Chi tiết sử dụng phòng + dịch vụ theo ngày |
| `HoaDon` | `maPTP` | Hóa đơn — 1:1 với PTP, tổng tiền |
| `LienHe` | `id` | Liên hệ từ website |
| `PhanHoi` | `id` | Phản hồi từ website |

---

## 8. Lỗi thường gặp & Cách xử lý

### Lỗi 1: "Unable to find the requested .NET Framework Data Provider"

**Nguyên nhân:** Thiếu provider SQLite cho Entity Framework hoặc `DatabaseProvider` trong `Web.config` không khớp provider đã cài.

**Cách xử lý:**
1. Mở `Web.config` trong `src/DoAn/`
2. Kiểm tra `appSettings > DatabaseProvider`:
   - SQLite: `<add key="DatabaseProvider" value="SQLite" />`
   - SQL Server: `<add key="DatabaseProvider" value="SqlServer" />`
3. Nếu dùng SQLite mà gặp lỗi, đảm bảo NuGet package `System.Data.SQLite.EF6` đã được restore.

---

### Lỗi 2: "Could not find a part of the path ... database/app.db"

**Nguyên nhân:** Thư mục `database` chưa tồn tại hoặc ứng dụng không có quyền ghi.

**Cách xử lý:**
```batch
# Tạo thư mục database nếu chưa có
mkdir "src\DoAn\database"
```
Nếu chạy trên IIS, cấp quyền **Write** cho Application Pool user trên thư mục `database`.

---

### Lỗi 3: "The 'maP' property on 'Phong' could not be set to a 'String' value..."

**Nguyên nhân:** Lỗi type mismatch giữa EDMX model và database thực tế (thường xảy ra khi dùng SQLite với schema khác).

**Cách xử lý:**
1. Mở `DoAn.edmx` trong Visual Studio
2. Right-click → **Update Model from Database**
3. Refresh các bảng bị lỗi
4. Build lại project

---

### Lỗi 4: "Login failed" khi đăng nhập dù đúng tài khoản

**Nguyên nhân:** Database chưa được seed dữ liệu hoặc bảng `QuanTri` trống.

**Cách xử lý:**
1. Kiểm tra bảng `QuanTri` trong database có dữ liệu chưa
2. Chạy lại `Setup.bat` để khởi tạo dữ liệu mẫu
3. Hoặc chạy thủ công file `SQL_DoAn.sql` trên SQL Server

---

### Lỗi 5: "Server Error in '/' Application — Configuration Error"

**Nguyên nhân:** `Web.config` có lỗi cú pháp XML (thường do chỉnh sửa thủ công làm sai connection string).

**Cách xử lý:**
1. Restore `Web.config` từ backup: `Web.config.bak` (nếu có)
2. Kiểm tra kỹ các ký tự đặc biệt trong connection string (`&`, `"`, `<`, `>`) đã được escape đúng chưa
3. Validate XML: mở `Web.config` trong Visual Studio, IDE sẽ highlight lỗi

---

### Lỗi 6: "This request requires authentication" / 401 khi truy cập trang admin

**Nguyên nhân:** Chưa đăng nhập hoặc session đã hết hạn.

**Cách xử lý:**
1. Truy cập `/Login` để đăng nhập
2. Kiểm tra timeout trong `Web.config`:
   ```xml
   <authentication mode="Forms">
     <forms timeout="1" />  <!-- 1 phút — tăng lên nếu cần -->
   </authentication>
   ```

---

### Lỗi 7: "Unable to cast object of type 'System.DBNull' to type 'System.String'"

**Nguyên nhân:** Model (`.cs`) khai báo thuộc tính nullable (`string?`) nhưng EDMX ánh xạ sang non-nullable, hoặc ngược lại.

**Cách xử lý:**
1. Mở file `.cs` tương ứng trong `Models/`
2. Sửa kiểu dữ liệu cho phù hợp: thêm `?` cho nullable
   ```csharp
   public string? soTienCoc { get; set; }
   ```

---

### Lỗi 8: Trang admin không load đúng layout (css/js trắng hoặc lỗi)

**Nguyên nhân:** Bundle chưa được build đúng hoặc đường dẫn Assets sai.

**Cách xử lý:**
1. Trong `BundleConfig.cs`, kiểm tra đường dẫn bundle có đúng với thư mục `Assets/Admin/`
2. Chạy `BundleTable.EnableOptimizations = false;` tạm thời trong `Global.asax` để debug
3. Kiểm tra thư mục `Assets/Admin/vendor/` có đầy đủ file chưa

---

### Lỗi 9: "HTTP Error 500.19 - Internal Server Error" trên IIS

**Nguyên nhân:** `Web.config` có lỗi hoặc Application Pool không đúng phiên bản .NET.

**Cách xử lý:**
1. Đảm bảo Application Pool set **.NET CLR Version = v4.0**
2. Enable **32-bit Applications = True** nếu dùng SQLite 32-bit
3. Cấp quyền Read/Write cho Application Pool user trên thư mục project

---

### Lỗi 10: "The database file is locked" (SQLite)

**Nguyên nhân:** File `.db` đang bị mở bởi process khác (VD: SQLite Browser đang mở).

**Cách xử lý:**
1. Đóng tất cả ứng dụng đang truy cập file `.db`
2. Kill process `sqlite3.exe` nếu đang chạy
3. Khởi động lại ứng dụng

---

## Liên hệ

- **An-Huynh** — Đồ án Hệ Thống Thông Tin
- Trường đại học liên quan: (bổ sung thông tin trường tại đây)
