using System.Collections.Generic;
using System.Threading.Tasks;
using ProjetoPratica_API.Models;
using System.Data;
using System;

namespace ProjetoPratica_API.Data
{
    public interface IRepository
    {
        // Métodos genéricos
        void Add<T>(T entity) where T : class;
        void Update<T>(T entity) where T : class;
        void Delete<T>(T entity) where T : class;
        void Entry<T>(T entity) where T : class;
        Task<bool> SaveChangesAsync();

        Task<Idoso[]> GetAllIdosos();
        Task<Idoso> GetIdosoById(int Id);
        Task<Remedio[]> GetAllRemedios();
        Task<Remedio> GetRemedioById(int Id);
        List<Object> GetRemedioIdoso(string codIdoso);
        List<Object> GetHorariosRemedios();

    }

}