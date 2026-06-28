using System.Data.Entity;

namespace DoAn.Models
{
    public static class DbInitializer
    {
        public static void Initialize()
        {
            using (var db = new DoAnEntities())
            {
                db.Database.CreateIfNotExists();
            }
        }
    }
}
