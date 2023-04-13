using DevExpress.DashboardCommon;
using DevExpress.DashboardWeb;
using DevExpress.DataAccess.Excel;
using DevExpress.DataAccess.Sql;
using DevExpress.Web;
using DXWebApplication1.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Web.Hosting;
using System.Web.UI.WebControls;
using System.Linq;

namespace DXWebApplication1
{

    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region ReadOnly

        private readonly string _connectionString = "Data Source=IPORT\\SQLEXPRESS; Integrated Security=True; Initial Catalog=iPortCrud;";
        private readonly DateTime date = DateTime.Now;

        #endregion ReadOnly

        #region Enumeradores

        private enum AcaoCallBack
        {
            Filtrar,
            Limpar,
            AbrirFormularioDelecao,
            ConfirmarDelecao,
            CancelarDelecao,
            AbrirFormularioCriacao,
            ConfirmarCriacao,
            CancelarCriacao,

        }
        private enum AcaoVisualizacaoTela
        {
            VisualizarFormDelecao,
            VisualizarTelaPrincipal,
            VisualizarFormCriacao,
        }
        
        #endregion Enumeradores 

        #region Funções para manipular tela
        public void delete_Fields()
        {
            PesquisaNomeCliente.Text = "";
            PesquisaDataInicio.Text = "";
            PesquisaDataFim.Text = "";
            PesquisaCPFCliente.Text = "";

            ASPxGridView1.DataBind();
        }
        protected void limparCamposFormDelete()
        {
            motivoExclusao.Text = "";
            usuarioReponsavel.Text = "";
        }
        private void visualizacaoTela(AcaoVisualizacaoTela acaoVisualizacaoTela)
        {

            switch (acaoVisualizacaoTela)
            {
                case AcaoVisualizacaoTela.VisualizarFormDelecao:
                    panelDelete.Visible = true;
                    pnlFiltro.Visible = false;
                    Menu.Visible = false;
                    ASPxGridView1.Visible = false;
                    DependentesGrid.Visible = false;
                    break;

                case AcaoVisualizacaoTela.VisualizarTelaPrincipal:
                    panelDelete.Visible = false;
                    pnlFiltro.Visible = true;
                    Menu.Visible = true;
                    ASPxGridView1.Visible = true;
                    DependentesGrid.Visible = false;
                    break;
                case AcaoVisualizacaoTela.VisualizarFormCriacao:
                    panelDelete.Visible = false;
                    pnlFiltro.Visible = false;
                    Menu.Visible = false;
                    ASPxGridView1.Visible = false;
                    CreatePanel.Visible = true;
                    DependentesGrid.ClientVisible = true;
                    AddDependente.ClientVisible = true;
                    break;

            }

        }

        #endregion Funções para manipular tela

        #region callbacks e interações
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

            else if (e.Parameter.Equals(AcaoCallBack.AbrirFormularioCriacao.ToString())) 
            {
                visualizacaoTela(AcaoVisualizacaoTela.VisualizarFormCriacao);
                                
            }

            else if (e.Parameter.Equals(AcaoCallBack.ConfirmarCriacao.ToString()))
            {
                CadastroPessoaFisica();
            }

            else if (e.Parameter.Equals(AcaoCallBack.CancelarCriacao.ToString()))
            {
                visualizacaoTela(AcaoVisualizacaoTela.VisualizarTelaPrincipal);
                listaPessoaFisicaVinculadas.Clear();
                DependentesGrid.DataBind();
            }

            else if (e.Parameter.Equals(AcaoCallBack.AbrirFormularioDelecao.ToString()))
            {

                visualizacaoTela(AcaoVisualizacaoTela.VisualizarFormDelecao);
                limparCamposFormDelete();

                //var rowStatus = Convert.ToInt32(HiddenStatusUsuario.Get("StatusValue").ToString());
                //int statusValue = (int)ASPxGridView1.GetRowValues(rowStatus, "STATUS");
                //if (statusValue == 1)
                //{
                   
                //} 
                //else if (statusValue == 2)
                //{

                //    ASPxCallbackPanel cp = sender as ASPxCallbackPanel;
                //    cp.JSProperties["cpAlert"] = "javascript:showMessageBox()";
                //}

            }
            else if (e.Parameter.Equals(AcaoCallBack.ConfirmarDelecao.ToString()))
            {
                ConfirmarDelecaoPessoaFisica();

            }
            else if (e.Parameter.Equals(AcaoCallBack.CancelarDelecao.ToString()))
            {
                visualizacaoTela(AcaoVisualizacaoTela.VisualizarTelaPrincipal);
                limparCamposFormDelete();
            }
        }
        
        #endregion callbacks e interação

        #region Funções gridPessoaFisica
        protected void ASPxGridView1_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            var pessoaFisica = new PessoaFisica();
            pessoaFisica.Nome = e.NewValues["NOME"] != null ? e.NewValues["NOME"].ToString() : null;
            pessoaFisica.Cpf = e.NewValues["CPF"] != null ? e.NewValues["CPF"].ToString() : null;
            pessoaFisica.Email = e.NewValues["EMAIL"] != null ? e.NewValues["EMAIL"].ToString() : null;
            if (e.NewValues["DATANASCIMENTO"] != null) pessoaFisica.DataDeNascimento = Convert.ToDateTime(e.NewValues["DATANASCIMENTO"].ToString());
            pessoaFisica.Genero = e.NewValues["GENERO"] != null ? e.NewValues["GENERO"].ToString() : null;
            pessoaFisica.Celular = e.NewValues["CELULAR"] != null ? e.NewValues["CELULAR"].ToString() : null;
            pessoaFisica.Senha = e.NewValues["SENHA"] != null ? e.NewValues["SENHA"].ToString() : null;

            InsertData(pessoaFisica);
            /* 
               Ao tentar inserir um novo registro, todos os valores inseridos nos campos do editform podem ser acessados 
               atraves do AspxDataInsertingEventArgs.
               para pegar os valores dos campos serão acessados os índices desses valores através da propriedade
               NewValues. Desta forma acessamos o índice através do nome do campo.

               Ex: e.NewValues["nomeCampo"] ou e.NewValues[nameof(...)]
            


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
        protected void ASPxGridView1_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            var pessoaFisica = new PessoaFisica();
            pessoaFisica.id = e.Keys["ID"] != null ? int.Parse(e.Keys["ID"].ToString()) : 0;
            pessoaFisica.Nome = e.NewValues["NOME"] != null ? e.NewValues["NOME"].ToString() : null;
            pessoaFisica.Cpf = e.NewValues["CPF"] != null ? e.NewValues["CPF"].ToString() : null;
            pessoaFisica.Email = e.NewValues["EMAIL"] != null ? e.NewValues["EMAIL"].ToString() : null;
            if (e.NewValues["DATANASCIMENTO"] != null) pessoaFisica.DataDeNascimento = Convert.ToDateTime(e.NewValues["DATANASCIMENTO"].ToString());
            pessoaFisica.Genero = e.NewValues["GENERO"] != null ? e.NewValues["GENERO"].ToString() : null;
            pessoaFisica.Celular = e.NewValues["CELULAR"] != null ? e.NewValues["CELULAR"].ToString() : null;
            pessoaFisica.Senha = e.NewValues["SENHA"] != null ? e.NewValues["SENHA"].ToString() : null;

            UpdateData(pessoaFisica);
        }
        protected void ASPxGridView1_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
        {
            try
            {
                e.ExceptionHandled = true;
            }

            catch
            {

            }
        }
        protected void ASPxGridView1_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {

            //SqlPessoa_Init(null, null);
            //var pessoaFisica = new PessoaFisica();
            //pessoaFisica.id = e.Keys["ID"] != null ? e.Keys["ID"].ToString() : null;

            //DeleteData(pessoaFisica.id);

        }
        protected void ASPxGridView1_RowDeleted(object sender, DevExpress.Web.Data.ASPxDataDeletedEventArgs e)
        {
            try
            {
                e.ExceptionHandled = true;
            }

            catch
            {

            }

        }
        protected void ASPxGridView1_CustomButtonInitialize(object sender, ASPxGridViewCustomButtonEventArgs e)
        {


            if (e.ButtonID == "deleteButton")
            {
                Int32 status = Convert.ToInt32(ASPxGridView1.GetRowValues(e.VisibleIndex, "STATUS"));

                if (status == 2)
                {
                    e.Enabled = false;
                }

            }

        }

        #endregion Funções gridPessoaFisica

        #region Funções Manipulação de dados 
        protected void DeleteData(int id, DateTime? data, string descricao, string responsavel)
        {


            using (SqlConnection connection = new SqlConnection(_connectionString))
            {

                connection.Open();

                string queryUpdate = $@"UPDATE iPortCrud.dbo.usuarios SET 
                    status = '2'
                    WHERE id = {id};";

                string queryInsert = $@"INSERT INTO iPortCrud.dbo.ocorrencias (usuario_id, data, descricao, responsavel) 
                                VALUES ('{id}', 
                                        '{data}', 
                                        '{descricao}',
                                        '{responsavel}')";



                SqlCommand commandUpdate = new SqlCommand(queryUpdate, connection);
                commandUpdate.ExecuteNonQuery();


                SqlCommand commandInsert = new SqlCommand(queryInsert, connection);
                commandInsert.ExecuteNonQuery();

                ASPxGridView1.DataBind();

                connection.Close();

            }
        }
        protected void InsertData(PessoaFisica pessoaFisica)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                string query = $@"INSERT INTO iPortCrud.dbo.usuarios (nome, cpf, email, data_nascimento, genero, celular, senha) 
                                VALUES ('{pessoaFisica.Nome}', 
                                        '{pessoaFisica.Cpf}', 
                                        '{pessoaFisica.Email}', 
                                        '{pessoaFisica.DataDeNascimento}', 
                                        '{pessoaFisica.Genero}', 
                                        '{pessoaFisica.Celular}', 
                                        '{pessoaFisica.Senha}')";

                SqlCommand command = new SqlCommand(query, connection);
                command.ExecuteNonQuery();

                SqlPessoa_Init(null, null);
                ASPxGridView1.DataBind();

                connection.Close();

            }
        }
        protected void UpdateData(PessoaFisica pessoaFisica)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                string query = $@"UPDATE iPortCrud.dbo.usuarios SET 
                    nome = '{pessoaFisica.Nome}', 
                    cpf = '{pessoaFisica.Cpf}',
                    email = '{pessoaFisica.Email}', 
                    data_nascimento = '{pessoaFisica.DataDeNascimento}', 
                    genero = '{pessoaFisica.Genero}', 
                    celular = '{pessoaFisica.Celular}', 
                    senha = '{pessoaFisica.Senha}'
                    WHERE id = {pessoaFisica.id};";

                   SqlCommand command = new SqlCommand(query, connection);
                command.ExecuteNonQuery();

                SqlPessoa_Init(null, null);
                ASPxGridView1.DataBind();

                connection.Close();

            }
        }
        public void ConfirmarDelecaoPessoaFisica() 
        {
            if (motivoExclusao.Text != string.Empty && usuarioReponsavel.Text != string.Empty)
            {
                Int32 idUsuario = Convert.ToInt32(HiddenIdUsuario.Get("IDUsuario").ToString());
                Ocorrencia ocorrencia = new Ocorrencia();
                ocorrencia.Data = date;
                ocorrencia.Descricao = motivoExclusao.Text;
                ocorrencia.Responsavel = usuarioReponsavel.Text;
                ocorrencia.Usuario_id = idUsuario;

                DeleteData(ocorrencia.Usuario_id, ocorrencia.Data, ocorrencia.Descricao, ocorrencia.Responsavel);
                ASPxGridView1.DataBind();
                limparCamposFormDelete();
            }
            else
            {
                visualizacaoTela(AcaoVisualizacaoTela.VisualizarFormDelecao);
                limparCamposFormDelete();
            }
        }
        public void CadastroPessoaFisica()
        {
            PessoaFisica pessoaFisica = new PessoaFisica();
            pessoaFisica.Nome = nomePessoaFisica.Text;
            pessoaFisica.Cpf = cpfPessoaFisica.Text.ToString();
            pessoaFisica.Email = emailPessoaFisica.Text;
            pessoaFisica.DataDeNascimento = Convert.ToDateTime(DataNasc.Text);
            pessoaFisica.Genero = cbGenero.Text;
            pessoaFisica.Celular = celularPessoaFisica.Text;
            pessoaFisica.Senha = senhaPessoaFisica.Text;

            foreach (PessoaFisica pfFilho in listaPessoaFisicaVinculadas)
            {
                Dependente dp = new Dependente();
                dp.PFFilho = pfFilho;
                dp.PFPai = pessoaFisica;
                dp.Id = -1 - listaPessoaFisicaVinculadas.Count;
                dp.IdPessoaFisicaDependente = pfFilho.id;
                dp.IdPessoaFisicaPai = pessoaFisica.id;
                dp.TipoDependente = "Filho";
                dp.DataCriacao = date;
                dp.DataAlteracao = date;
                pessoaFisica.Dependentes.Add(dp);
            }

        }

        #endregion Funções manipulação de dados no banco

        #region Object e Sql DataSources
        enum Status
        {
            Ativo = 1,
            Excluido = 2,
        }
        enum Genero
        {
            Masculino = 0,
            Feminino = 1,
            NaoBinario = 2
        }
        public DataTable GetAllStatus()
        {

            DataTable dataTable = new DataTable();
            dataTable.Columns.Add("Value", typeof(int));
            dataTable.Columns.Add("Name", typeof(string));

            foreach (var value in Enum.GetValues(typeof(Status)))
            {
                DataRow row = dataTable.NewRow();
                row["Value"] = (int)value;
                row["Name"] = Enum.GetName(typeof(Status), value);
                dataTable.Rows.Add(row);

            }

            return dataTable;
        }
        public DataTable GetAllGenders()
        {
            DataTable dataTable = new DataTable();
            dataTable.Columns.Add("Value", typeof(int));
            dataTable.Columns.Add("Name", typeof(string));

            foreach (var value in Enum.GetValues(typeof(Genero)))
            {
                DataRow row = dataTable.NewRow();
                row["Value"] = (int)value;
                row["Name"] = Enum.GetName(typeof(Genero), value);
                dataTable.Rows.Add(row);
            }

            return dataTable;
        }
        public List<PessoaFisica> GetAllDependentes()
        {
            return listaPessoaFisicaVinculadas;

        }
        protected void SqlPessoa_Init(object swender, EventArgs e)
        {

            string strConsulta = $@"select 
	                                    id as ID,
	                                    nome as NOME,
	                                    cpf as CPF,
	                                    email as EMAIL,
	                                    data_nascimento as DATANASCIMENTO,
	                                    genero as GENERO,
	                                    celular as CELULAR,
	                                    senha as SENHA,
                                        status as STATUS

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
            ASPxGridView1.DataBind();

        }

        protected static List<PessoaFisica> listaPessoaFisicaVinculadas = new List<PessoaFisica>();
        #endregion Object e Sql DataSources

        #region Funções gridDependentePessoaFisicaDependente
        protected void DependentesGrid_RowInserting1(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            
            PessoaFisica dependente = new PessoaFisica();
            dependente.id = -1 - listaPessoaFisicaVinculadas.Count;
            dependente.Nome = e.NewValues["Nome"] != null ? e.NewValues["Nome"].ToString() : null;
            dependente.Cpf = e.NewValues["Cpf"] != null ? e.NewValues["Cpf"].ToString() : null;
            dependente.DataDeNascimento = e.NewValues["DataDeNascimento"] != null ? DateTimeOffset.Parse(e.NewValues["DataDeNascimento"].ToString()) : (DateTimeOffset?)null;
            dependente.Email = e.NewValues["Email"] != null ? e.NewValues["Email"].ToString() : null;
            dependente.Celular = e.NewValues["Celular"] != null ? e.NewValues["Celular"].ToString() : null;
            dependente.Genero = e.NewValues["Genero"] != null ? e.NewValues["Genero"].ToString() : null;
            dependente.Status = 1;
            
            
            //listaPessoaFisicaVinculadas.Find(s => s.id == 1);


            listaPessoaFisicaVinculadas.Add(dependente);
        }
        protected void DependentesGrid_RowInserted(object sender, DevExpress.Web.Data.ASPxDataInsertedEventArgs e)
        {
            try
            {
                e.ExceptionHandled = true;
            }

            catch
            {

            }
        }
        protected void DependentesGrid_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            int id = Convert.ToInt32(e.Keys["id"].ToString());
            PessoaFisica pessoa = listaPessoaFisicaVinculadas.FirstOrDefault(s => s.id == id);

            if (pessoa != null)
            {
                pessoa.Nome = e.NewValues["Nome"].ToString();
                pessoa.Cpf = e.NewValues["Cpf"].ToString();
                pessoa.DataDeNascimento = Convert.ToDateTime(e.NewValues["DataDeNascimento"].ToString());
                pessoa.Email = e.NewValues["Email"] != null ? e.NewValues["Email"].ToString() : null;
                pessoa.Celular = e.NewValues["Celular"] != null ? e.NewValues["Celular"].ToString() : null;
                pessoa.Genero = e.NewValues["Genero"] != null ? e.NewValues["Genero"].ToString() : null;
                pessoa.Genero = e.NewValues["Status"] != null ? e.NewValues["Genero"].ToString() : null;

            }
        }
        protected void DependentesGrid_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int id = Convert.ToInt32(e.Keys["id"].ToString());
            PessoaFisica pessoa = listaPessoaFisicaVinculadas.FirstOrDefault(s => s.id == id);

            if (pessoa != null)
            {   
                listaPessoaFisicaVinculadas.Remove(pessoa);
                DependentesGrid.DataBind();
            }

        }
        protected void DependentesGrid_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
        {
            try
            {
                e.ExceptionHandled = true;
            }

            catch
            {

            }
        }
        protected void DependentesGrid_RowDeleted(object sender, DevExpress.Web.Data.ASPxDataDeletedEventArgs e)
        {
            try
            {
                e.ExceptionHandled = true;
            }

            catch
            {

            }
        }

        #endregion Funções gridDependentePessoaFisicaDependente
    }
} 