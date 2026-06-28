using System.Data.Entity;

namespace DoAn.Models
{
    public class SQLiteEntities : DbContext
    {
        public SQLiteEntities()
            : base("name=SQLiteConn")
        {
        }

        public SQLiteEntities(string connectionString)
            : base(connectionString)
        {
        }

        public DbSet<CTPhieuDatPhong> CTPhieuDatPhongs { get; set; }
        public DbSet<CTPhieuThuePhong> CTPhieuThuePhongs { get; set; }
        public DbSet<DanhSachQuyen> DanhSachQuyens { get; set; }
        public DbSet<DichVu> DichVus { get; set; }
        public DbSet<HoaDon> HoaDons { get; set; }
        public DbSet<KhachHang> KhachHangs { get; set; }
        public DbSet<LienHe> LienHes { get; set; }
        public DbSet<LoaiPhong> LoaiPhongs { get; set; }
        public DbSet<NhanVien> NhanViens { get; set; }
        public DbSet<NhomNhanVien> NhomNhanViens { get; set; }
        public DbSet<PhanHoi> PhanHois { get; set; }
        public DbSet<PhieuDatPhong> PhieuDatPhongs { get; set; }
        public DbSet<PhieuThuePhong> PhieuThuePhongs { get; set; }
        public DbSet<Phong> Phongs { get; set; }
        public DbSet<QuanTri> QuanTris { get; set; }
        public DbSet<Quyen> Quyens { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
        }
    }
}
