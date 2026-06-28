using System.Configuration;

namespace DoAn.Models
{
    public static class DbFactory
    {
        public static DoAnEntities Create()
        {
            return new DoAnEntities("name=DoAnEntities");
        }
    }
}
