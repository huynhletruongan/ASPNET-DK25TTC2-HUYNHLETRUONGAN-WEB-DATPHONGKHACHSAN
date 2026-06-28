using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using DoAn.Common;
using DoAn.Models;

namespace DoAn.Controllers
{
    public class KhachHangsController : BaseController
    {
        private readonly DoAnEntities db = DbFactory.Create();

        string LayMaKH()
        {
            var maMAX = db.KhachHangs.ToList().Select(n => n.maKH).Max();
            int MaKH = int.Parse(maMAX.Substring(2)) + 1;
            string KH = String.Concat("000", MaKH.ToString());
            return "KH" + KH.Substring(MaKH.ToString().Length - 1);
        }

        [HttpGet]
        public ActionResult Search(string MaKH = "", string TenKH = "", string GioiTinh = "", string Cmnd_passport = "", string DiaChi = "", string QuocTich = "", string Email = "", string Sdt = "")
        {
            if (GioiTinh != "1" && GioiTinh != "0")
                GioiTinh = null;
            ViewBag.MaKH = MaKH;
            ViewBag.TenKH = TenKH;
            ViewBag.GioiTinh = GioiTinh;
            ViewBag.Cmnd_passport = Cmnd_passport;
            ViewBag.DiaChi = DiaChi;
            ViewBag.QuocTich = QuocTich;
            ViewBag.Email = Email;
            ViewBag.Sdt = Sdt;
            var khachHangs = db.KhachHangs
                .Where(x => string.IsNullOrEmpty(MaKH) || x.maKH.Contains(MaKH))
                .Where(x => string.IsNullOrEmpty(TenKH) || x.tenKH.Contains(TenKH))
                .Where(x => string.IsNullOrEmpty(GioiTinh) || x.gioiTinh == (GioiTinh == "1"))
                .Where(x => string.IsNullOrEmpty(Cmnd_passport) || x.cmnd_passport.Contains(Cmnd_passport))
                .Where(x => string.IsNullOrEmpty(DiaChi) || x.diaChi.Contains(DiaChi))
                .Where(x => string.IsNullOrEmpty(QuocTich) || x.quocTich.Contains(QuocTich))
                .Where(x => string.IsNullOrEmpty(Email) || x.email.Contains(Email))
                .Where(x => string.IsNullOrEmpty(Sdt) || x.sdt.Contains(Sdt))
                .ToList();
            if (khachHangs.Count == 0)
                ViewBag.TB = "Không có thông tin khách hàng này!";
            return View(khachHangs);
        }

        public ActionResult Index()
        {
            return View(db.KhachHangs.ToList());
        }

        // GET: KhachHangs/Details/5
        [HasCredential(IDQuyen = "QUANLYKHACHHANG")]
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            KhachHang khachHang = db.KhachHangs.Find(id);
            if (khachHang == null)
            {
                return HttpNotFound();
            }
            return View(khachHang);
        }

        // GET: KhachHangs/Create
        [HasCredential(IDQuyen = "QUANLYKHACHHANG")]
        public ActionResult Create()
        {
            ViewBag.maKH = LayMaKH();
            return View();
        }

        // POST: KhachHangs/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [HasCredential(IDQuyen = "QUANLYKHACHHANG")]
        public ActionResult Create([Bind(Include = "maKH,tenKH,gioiTinh,cmnd_passport,diaChi,quocTich,email,sdt")] KhachHang khachHang)
        {
            if (ModelState.IsValid)
            {
                db.KhachHangs.Add(khachHang);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.maKH = LayMaKH();
            return View(khachHang);
        }

        // GET: KhachHangs/Edit/5
        [HasCredential(IDQuyen = "QUANLYKHACHHANG")]
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            KhachHang khachHang = db.KhachHangs.Find(id);
            if (khachHang == null)
            {
                return HttpNotFound();
            }
            return View(khachHang);
        }

        // POST: KhachHangs/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [HasCredential(IDQuyen = "QUANLYKHACHHANG")]
        public ActionResult Edit([Bind(Include = "maKH,tenKH,gioiTinh,cmnd_passport,diaChi,quocTich,email,sdt")] KhachHang khachHang)
        {
            if (ModelState.IsValid)
            {
                db.Entry(khachHang).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(khachHang);
        }

        // GET: KhachHangs/Delete/5
        [HasCredential(IDQuyen = "QUANLYKHACHHANG")]
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            KhachHang khachHang = db.KhachHangs.Find(id);
            if (khachHang == null)
            {
                return HttpNotFound();
            }
            return View(khachHang);
        }

        // POST: KhachHangs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        [HasCredential(IDQuyen = "QUANLYKHACHHANG")]
        public ActionResult DeleteConfirmed(string id)
        {
            KhachHang khachHang = db.KhachHangs.Find(id);
            db.KhachHangs.Remove(khachHang);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
