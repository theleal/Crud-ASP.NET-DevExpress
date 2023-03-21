using DevExpress.DashboardCommon;
using DevExpress.DashboardWeb;
using DevExpress.DataAccess.Excel;
using DevExpress.DataAccess.Sql;
using DXWebApplication1.Models;
using System;
using System.Data.SqlClient;
using System.Web.Hosting;

namespace DXWebApplication1 {

    public partial class Default : System.Web.UI.Page 
    {

        private string _connectionString = "Data Source=IPORT\\SQLEXPRESS; Integrated Security=True; Initial Catalog=iPortCrud;";

        protected void Page_Load(object sender, EventArgs e) 
        {
            


        }

        #region Enumeradores

        private enum AcaoCallBack
        { 
            Filtrar,
            Limpar,
        }

        #endregion

        protected void SqlPessoa_Init(object sender, EventArgs e)
        {

            string strConsulta = $@"select 
	                                    id as ID,
	                                    nome as NOME,
	                                    cpf as CPF,
	                                    email as EMAIL,
	                                    data_nascimento as DATANASCIMENTO,
	                                    genero as GENERO,
	                                    celular as CELULAR,
	                                    senha as SENHA 

                                from iPortCrud.dbo.usuarios
                                where id is not null ";

            if (!string.IsNullOrEmpty(PesquisaNomeCliente.Text))            
                strConsulta += $@"and nome like '%{PesquisaNomeCliente.Text}%'";            

            if (!string.IsNullOrEmpty(PesquisaCPFCliente.Text))
                strConsulta += $@"and cpf like '%{PesquisaCPFCliente.Text}%'";


            if (!string.IsNullOrEmpty(PesquisaDataInicio.Text) && (!string.IsNullOrEmpty(PesquisaDataFim.Text)))
            {
                strConsulta += $@"and data_nascimento BETWEEN '{PesquisaDataInicio.Text}' AND '{PesquisaDataFim.Text}' ";
            } 
            
            else if (!string.IsNullOrEmpty(PesquisaDataInicio.Text) && (string.IsNullOrEmpty(PesquisaDataFim.Text)))
            {
                strConsulta += $@"and data_nascimento >= '{PesquisaDataInicio.Text}' ";
            } 

            SqlPessoa.SelectCommand = strConsulta;
            
        }

        protected void SqlPessoa_Selecting(object sender, System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs e)
        {
            //e.Command.Parameters["@NomeUsuario"].Value = !string.IsNullOrEmpty(PesquisaNomeCliente.Text) ? PesquisaNomeCliente.Text.ToString(): " ";
        }

        protected void btnFiltro_Click(object sender, EventArgs e)
        {
            SqlPessoa_Init(null, null);

            //Função DataBind é utilizada para DAR UM REFRESH NO GRID
            ASPxGridView1.DataBind(); 
        }

        public void search_CPF()
        {

            SqlPessoa_Init(null, null);
            ASPxGridView1.DataBind();
        }

        protected void CallbackPanel_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            if (e.Parameter.Equals(AcaoCallBack.Limpar.ToString()))
            {
                delete_Fields();
            }

            else if (e.Parameter.Equals(AcaoCallBack.Filtrar.ToString()))
            {
                search_CPF();
            }

        }

        public void delete_Fields()
        {
                PesquisaNomeCliente.Text = "";
                PesquisaDataInicio.Text = "";
                PesquisaDataFim.Text = "";
                PesquisaCPFCliente.Text = "";

                ASPxGridView1.DataBind();
        }

        public void InsertData(string nome, string cpf, string email, DateTimeOffset? datanascimento, string genero, string celular, string senha)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString)) 
            {
                connection.Open();

                string query = $@"INSERT INTO iPortCrud.dbo.usuarios (nome, cpf, email, data_nascimento, genero, celular, senha) 
                                VALUES ('{nome}', 
                                        '{cpf}', 
                                        '{email}', 
                                        '{datanascimento}', 
                                        '{genero}', 
                                        '{celular}', 
                                        '{senha}')";

                SqlCommand command = new SqlCommand(query, connection);
                command.ExecuteNonQuery();

                SqlPessoa_Init(null, null);
                ASPxGridView1.DataBind();

                connection.Close();

            }
        }

        protected void ASPxGridView1_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            var pessoaFisica = new PessoaFisica();
            pessoaFisica.Nome = e.NewValues["NOME"] != null ? e.NewValues["NOME"].ToString() : null;
            pessoaFisica.Cpf = e.NewValues["CPF"] != null ? e.NewValues["CPF"].ToString() : null;
            pessoaFisica.Email = e.NewValues["EMAIL"] != null ? e.NewValues["EMAIL"].ToString() : null;
            if (e.NewValues["DATANASCIMENTO"] != null)pessoaFisica.Data = Convert.ToDateTime(e.NewValues["DATANASCIMENTO"].ToString());
            pessoaFisica.Genero = e.NewValues["GENERO"] != null ? e.NewValues["GENERO"].ToString() : null;
            pessoaFisica.Celular = e.NewValues["CELULAR"] != null ? e.NewValues["CELULAR"].ToString() : null;
            pessoaFisica.Senha = e.NewValues["SENHA"] != null ? e.NewValues["SENHA"].ToString() : null;
           
            InsertData(pessoaFisica.Nome, pessoaFisica.Cpf, pessoaFisica.Email, pessoaFisica.Data, pessoaFisica.Genero, pessoaFisica.Celular, pessoaFisica.Senha);
            /* 
               Ao tentar inserir um novo registro, todos os valores inseridos nos campos do editform podem ser acessados 
               atraves do AspxDataInsertingEventArgs.
               para pegar os valores dos campos serão acessados os índices desses valores através da propriedade
               NewValues. Desta forma acessamos o índice através do nome do campo.

               Ex: e.NewValues["nomeCampo"] ou e.NewValues[nameof(...)]
            */


            /*Ao finalizar o objeto novo, será feito a inclusão do dado no banco de dados*/

        }

        protected void ASPxGridView1_RowInserted(object sender, DevExpress.Web.Data.ASPxDataInsertedEventArgs e)
        {
            try
            {
                e.ExceptionHandled = true;
            }

            catch
            {

            }
        }

    }
}