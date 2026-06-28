using System.Data.Entity;
using DoAn.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace DoAn.Controllers
{
    public class ThongKeController : Controller
    {
        DoAnEntities db = DbFactory.Create();

        public ActionResult ByDichVu(string fromDate = "", string toDate = "")
        {
            if (fromDate == "" || toDate == "")
            {
                fromDate = "2000-01-01";
                toDate = "2050-01-01";
            }

            DateTime from = DateTime.Parse(fromDate);
            DateTime to = DateTime.Parse(toDate);

            ViewBag.fromDate = fromDate;
            ViewBag.toDate = toDate;

            var data = db.CTPhieuThuePhongs
                .Where(c => c.maDV != "DV0000")
                .Where(c => c.PhieuThuePhong.ngayThue >= from && c.PhieuThuePhong.ngayTra <= to)
                .Where(c => c.PhieuThuePhong.HoaDon != null)
                .GroupBy(c => new { c.maDV, c.DichVu.tenDV })
                .Select(g => new ThongKeDichVu
                {
                    maDV = g.Key.maDV,
                    tenDV = g.Key.tenDV,
                    TongDoanhThu = g.Sum(x => x.DichVu.gia * x.soLuong)
                })
                .ToList();

            return View(data);
        }
    }
}