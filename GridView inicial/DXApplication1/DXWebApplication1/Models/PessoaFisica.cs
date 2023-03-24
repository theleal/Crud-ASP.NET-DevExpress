using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DXWebApplication1.Models
{
    public class PessoaFisica
    {
        public PessoaFisica() { }

        public string id { get; set; }
        public string Nome { get; set; }
        public string Cpf { get; set; }
        public string Email { get; set; }
        public DateTimeOffset? Data { get; set; }
        public string Genero { get; set; }
        public string Celular { get; set; }
        public string Senha {get; set;}
        public string Status { get; set; }


    }
}