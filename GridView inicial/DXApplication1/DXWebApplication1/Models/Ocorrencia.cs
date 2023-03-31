using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DXWebApplication1.Models
{
    public class Ocorrencia
    {
        public Ocorrencia() { }

        public string Responsavel { get; set; }
        public int Id_ocorrencias { get; set; }
        public int Usuario_id { get; set; }
        public DateTime Data { get; set; }
        public string Descricao { get; set; }

    }
}
