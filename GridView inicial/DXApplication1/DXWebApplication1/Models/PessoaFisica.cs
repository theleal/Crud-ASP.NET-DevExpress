using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DXWebApplication1.Models
{
    public class PessoaFisica
    {
        public PessoaFisica() { }

        public int id { get; set; }
        public string Nome { get; set; }
        public string Cpf { get; set; }
        public string Email { get; set; }
        public DateTimeOffset? DataDeNascimento { get; set; }
        public string Genero { get; set; }
        public string Celular { get; set; }
        public string Senha {get; set;}
        public short Status { get; set; }
        public Ocorrencia Ocorrencia { get; set; }
        public List<Dependente> Dependentes { get; set; } = new List<Dependente>();
        public short tipoDependencia { get; set; }

    }
}