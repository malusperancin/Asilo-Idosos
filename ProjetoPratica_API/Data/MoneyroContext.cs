using Microsoft.EntityFrameworkCore;
using ProjetoPratica_API.Models;

namespace ProjetoPratica_API.Data
{
    public class MoneyroContext : DbContext
    {
        public MoneyroContext(DbContextOptions<MoneyroContext> options) : base(options)
        {
        }

        public DbSet<Idoso> TbIdoso { get; set; }
        public DbSet<Remedio> TbRemedio { get;set;}

    }
}