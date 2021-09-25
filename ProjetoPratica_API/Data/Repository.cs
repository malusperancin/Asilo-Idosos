using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ProjetoPratica_API.Data;
using Microsoft.EntityFrameworkCore;
using ProjetoPratica_API.Models;
using Microsoft.Data.SqlClient;
using System.Data;
using System;

namespace ProjetoPratica_API.Data
{
    public class Repository : IRepository
    {
        public MoneyroContext Context { get; }
        public Repository(MoneyroContext context)
        {
            this.Context = context;
        }
        public void Add<T>(T entity) where T : class
        {
            //throw new System.NotImplementedException();
            this.Context.Add(entity);
        }
        public void Delete<T>(T entity) where T : class
        {
            //throw new System.NotImplementedException();
            this.Context.Remove(entity);
        }
        public async Task<bool> SaveChangesAsync()
        {
            // Como é tipo Task vai gerar thread, então vamos definir o método como assíncrono (async)
            // Por ser assíncrono, o return deve esperar (await) se tem alguma coisa para salvar no BD
            // Ainda verifica se fez alguma alteração no BD, se for maior que 0 retorna true ou false
            return (await this.Context.SaveChangesAsync() > 0);
        }
        public void Update<T>(T entity) where T : class
        {
            //throw new System.NotImplementedException();
            this.Context.Update(entity);
        }

        public void Entry<T>(T entity) where T : class
        {
            this.Context.Entry(entity).State = EntityState.Detached;
        }

        public async Task<Idoso[]> GetAllIdosos()
        {
            //throw new System.NotImplementedException();
            //Retornar para uma query qualquer do tipo Aluno
            IQueryable<Idoso> consultaIdoso = (IQueryable<Idoso>)this.Context.TbIdoso;
            return await consultaIdoso.ToArrayAsync();
        }
        public async Task<Idoso> GetIdosoById(int Id)
        {

            //throw new System.NotImplementedException();
            //Retornar para uma query qualquer do tipo Aluno
            IQueryable<Idoso> consultaIdoso = (IQueryable<Idoso>)this.Context.TbIdoso;
            consultaIdoso = consultaIdoso.OrderBy(i => i.Id).Where(idoso => idoso.Id == Id);
            // aqui efetivamente ocorre o SELECT no BD
            return await consultaIdoso.FirstOrDefaultAsync();
        }
        public async Task<Remedio[]> GetAllRemedios()
        {
            //throw new System.NotImplementedException();
            //Retornar para uma query qualquer do tipo Aluno
            IQueryable<Remedio> consultaRemedio = (IQueryable<Remedio>)this.Context.TbRemedio;
            return await consultaRemedio.ToArrayAsync();
        }
        public async Task<Remedio> GetRemedioById(int Id)
        {

            //throw new System.NotImplementedException();
            //Retornar para uma query qualquer do tipo Aluno
            IQueryable<Remedio> consultaRemedio = (IQueryable<Remedio>)this.Context.TbRemedio;
            consultaRemedio = consultaRemedio.OrderBy(r => r.Id).Where(remedio => remedio.Id == Id);
            // aqui efetivamente ocorre o SELECT no BD
            return await consultaRemedio.FirstOrDefaultAsync();
        }
    }
}