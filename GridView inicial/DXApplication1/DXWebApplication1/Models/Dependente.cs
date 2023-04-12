using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DXWebApplication1.Models
{
    public class Dependente
    {
        public Dependente () {}

        public int Id { get; set; }
        public int IdPessoaFisicaDependente { get; set; }
        public int IdPessoaFisicaPai { get; set; }
        public string TipoDependente { get; set; }
        public DateTimeOffset DataCriacao { get; set; }
        public DateTimeOffset DataAlteracao{ get; set; }
        public int Status { get; set; }
        public PessoaFisica PFPai { get; set; }
        public PessoaFisica PFFilho { get; set; }









    }
}