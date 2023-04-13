<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Main.Master" CodeBehind="Default.aspx.cs" Inherits="DXWebApplication1.Default" %>

<%@ Register Assembly="DevExpress.Dashboard.v19.1.Web.WebForms, Version=19.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.DashboardWeb" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>


        function Callback_Client(s, acaoString) {
            CallbackPanel.PerformCallback(acaoString);
            e.cancel = true;
            e.processoOnServer = false;
        }

        function onClickMenu(s, e) {
            if (e.item.name == "CRIAR") {
                CallbackPanel.PerformCallback("AbrirFormularioCriacao");
                e.processoOnServer = false;
            }
        }

        function onButtonClick(s, e) {
            var fields = s.GetRowKey(e.visibleIndex);
            if (e.buttonID == "deleteButton") {
                HiddenIdUsuario.Set("IDUsuario", fields);

                /*                HiddenStatusUsuario.Set("StatusValue", e.visibleIndex)*/

                CallbackPanel.PerformCallback("AbrirFormularioDelecao");
                console.log(e.buttonID)
                e.processOnServer = false;


            }
            ASPxGridView1.SetVisible(true);
        }


        function Callback_Delecao(s, e) {
            CallbackPanel.PerformCallback(e)
            e.cancel = true;
            e.processoOnServer = false;
           
        }


        function Callback_Criacao(s, e) {
            CallbackPanel.PerformCallback(e)
            e.cancel = true;
            e.processoOnServer = false;
            console.log(e)

        }

        function showMessageBox() {
            alert("usuario ja excluido")
        }

        function CallbackPanel_endcallback(s, e) {
            try {
                if (s.cpAlert !== "undefined") {
                    eval(s.cpAlert)
                }
            }
            catch
            {

            }
        }

        function onClickAdd(s, e)
        {
            if (e.item.name == "ADICIONAR") {
                DependentesGrid.AddNewRow();
                e.processoOnServer = false;
            }
        }

    </script>

    <dx:ASPxHiddenField ClientInstanceName="HiddenIdUsuario" ID="HiddenIdUsuario" runat="server" />

    <dx:ASPxCallbackPanel
        runat="server"
        ID="CallbackPanel"
        ClientInstanceName="CallbackPanel"
        RenderMode="Div"
        OnCallback="CallbackPanel_Callback"
        ClientSideEvents-EndCallback="CallbackPanel_endcallback">
        <SettingsLoadingPanel Text="Carregando&amp;hellip;" />
        <PanelCollection>
            <dx:PanelContent runat="server">

                <%-- FORMULARIO DE FILTRO INICIO --%>
                <dx:ASPxRoundPanel
                    runat="server"
                    ID="pnlFiltro"
                    ClientInstanceName="pnlFiltro"
                    HeaderText=""
                    HeaderContent-BackColor="Transparent"
                    Width="100%"
                    BackColor="Transparent"
                    ShowHeader="false"
                    EnableViewState="false">
                    <Border BorderColor="Transparent" BorderStyle="None" />
                    <ContentPaddings Padding="0px" PaddingBottom="10px" PaddingLeft="0px" PaddingRight="0px" PaddingTop="25px" />


                    <HeaderContent BackColor="Transparent" />
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                             <dx:ASPxFormLayout
                                runat="server" ID="layoutFormulario" RequiredMarkDisplayMode="RequiredOnly"
                                EnableViewState="false" EncodeHtml="false" UseDefaultPaddings="true" Width="100%" AllowCollapsingByHeaderClick="true">
                                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="800" />
                                <Items>
                                    <dx:LayoutGroup Caption="" ColCount="2" SettingsItemHelpTexts-Position="Bottom" GroupBoxDecoration="None" Width="100%">
                                        <Items>
                                            <dx:LayoutItem Caption="Nome Usuário" Width="50%">
                                                <CaptionStyle Font-Bold="true" />
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>

                                                        <dx:ASPxTextBox
                                                            runat="server"
                                                            ID="PesquisaNomeCliente"
                                                            ClientInstanceName="PesquisaNomeCliente">
                                                        </dx:ASPxTextBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                            <dx:LayoutItem Caption="CPF:" Width="50%">
                                                <CaptionStyle Font-Bold="true" />
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>

                                                        <dx:ASPxTextBox
                                                            runat="server"
                                                            ID="PesquisaCPFCliente"
                                                            ClientInstanceName="PesquisaCPFCliente">
                                                        </dx:ASPxTextBox>

                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                            <dx:LayoutItem Caption="De:" Width="50%">
                                                <CaptionStyle Font-Bold="true" />
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>

                                                        <dx:ASPxDateEdit
                                                            runat="server"
                                                            ID="PesquisaDataInicio"
                                                            type="date"
                                                            ClientInstanceName="PesquisaDataInicio">
                                                        </dx:ASPxDateEdit>

                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                            <dx:LayoutItem Caption="Até:" Width="50%">
                                                <CaptionStyle Font-Bold="true" />
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>

                                                        <dx:ASPxDateEdit
                                                            runat="server"
                                                            ID="PesquisaDataFim"
                                                            type="date"
                                                            ClientInstanceName="PesquisaDataFim">
                                                        </dx:ASPxDateEdit>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                        </Items>

                                        <SettingsItemHelpTexts Position="Bottom"></SettingsItemHelpTexts>
                                    </dx:LayoutGroup>
                                </Items>
                            </dx:ASPxFormLayout>

                            <br />
                            <div style="display: flex; justify-content: flex-end; padding-right: 65px;">

                                <dx:ASPxButton
                                    runat="server"
                                    ID="btnFiltro"
                                    ClientInstanceName="ButtonFilter"
                                    Text="Filtrar">
                                    <ClientSideEvents Click="function(s, e) { Callback_Client(s, 'Filtrar'); }" />
                                </dx:ASPxButton>

                                <dx:ASPxButton
                                    runat="server"
                                    ID="btn_delete_Fields"
                                    ClientInstanceName="ButtonClear"
                                    Text="Limpar">
                                    <ClientSideEvents Click="function(s, e) { Callback_Client(s, 'Limpar'); }" />
                                </dx:ASPxButton>
                            </div>
                            <br />
                        </dx:PanelContent>
                    </PanelCollection>

                </dx:ASPxRoundPanel>
                <%-- FORMULARIO DE FILTRO FIM --%>


                <br />
                <%-- BOTAO MENU CRIAR INICIO --%>
                <dx:ASPxMenu
                    runat="server"
                    ClientInstanceName="Menu"
                    ShowAsToolbar="true"
                    ShowPopOutImages="true"
                    Theme="Office2010Blue"
                    ID="Menu">
                    <Items>
                        <dx:MenuItem Text="Criar" Name="CRIAR">
                            <Image IconID="actions_insert_16x16" />
                        </dx:MenuItem>
                    </Items>
                    <ClientSideEvents ItemClick="onClickMenu" />

                </dx:ASPxMenu>
                <br />
                <%-- BOTAO MENU CRIAR FIM --%>


                <%-- GRIDVIEW INICIO --%>
                <dx:ASPxGridView
                    ID="ASPxGridView1"
                    ClientInstanceName="ASPxGridView1"
                    OnRowUpdating="ASPxGridView1_RowUpdating"
                    OnRowUpdated="ASPxGridView1_RowUpdated"
                    OnRowInserting="ASPxGridView1_RowInserting"
                    OnRowInserted="ASPxGridView1_RowInserted"
                    OnRowDeleting="ASPxGridView1_RowDeleting"
                    OnRowDeleted="ASPxGridView1_RowDeleted"
                    OnCustomButtonInitialize="ASPxGridView1_CustomButtonInitialize"
                    DataSourceID="SqlPessoa"
                    AutoGenerateColumns="false"
                    runat="server"
                    Theme="Office2010Blue"
                    Width="100%"
                    KeyFieldName="ID"
                    Settings-ShowFilterRow="true"
                    Settings-AutoFilterCondition="Like">
                    <EditFormLayoutProperties ColumnCount="2">
                        <Items>

                            <dx:GridViewColumnLayoutItem ColumnName="status" Visible="false" Caption="status" />
                            <dx:GridViewColumnLayoutItem ColumnName="NOME" Visible="true" Caption="Nome" />
                            <dx:GridViewColumnLayoutItem ColumnName="CPF" Visible="true" Caption="CPF" />
                            <dx:GridViewColumnLayoutItem ColumnName="EMAIL" Visible="true" Caption="E-mail" />
                            <dx:GridViewColumnLayoutItem ColumnName="DATANASCIMENTO" Visible="true" Caption="Data de Nascimento" />
                            <dx:GridViewColumnLayoutItem ColumnName="CELULAR" Visible="true" Caption="Celular" />
                            <dx:GridViewColumnLayoutItem ColumnName="GENERO" Visible="true" Caption="Genero" />
                            <dx:GridViewColumnLayoutItem ColumnName="SENHA" Visible="true" Caption="Senha" Paddings-PaddingBottom="20px" />
                            <dx:EditModeCommandLayoutItem HorizontalAlign="Right" ShowUpdateButton="true" ShowCancelButton="true" />
                        </Items>
                    </EditFormLayoutProperties>

                    <ClientSideEvents CustomButtonClick="onButtonClick" />
                    <SettingsDataSecurity AllowDelete="True" AllowEdit="True" AllowInsert="True" />

                    <SettingsPopup>
                        <HeaderFilter MinHeight="140px" />
                    </SettingsPopup>

                    <SettingsCommandButton>
                        <EditButton ButtonType="Image">
                            <Image ToolTip="Editar" IconID="edit_edit_16x16" />
                        </EditButton>

                        <DeleteButton ButtonType="Image">
                            <Image ToolTip="Excluir" IconID="edit_delete_16x16" />
                        </DeleteButton>

                        <UpdateButton ButtonType="Button" Text="Confirmar">
                            <Image IconID="actions_apply_16x16" />
                        </UpdateButton>

                        <CancelButton ButtonType="Button" Text="Cancelar">
                            <Image IconID="actions_cancel_16x16" />
                        </CancelButton>

                    </SettingsCommandButton>
                    <Columns>


                        <dx:GridViewCommandColumn FooterCellStyle-HorizontalAlign="Left" SelectAllCheckboxMode="Page" Caption="Seleção" ShowSelectCheckbox="True" VisibleIndex="0" ButtonRenderMode="button">
                            <FooterCellStyle HorizontalAlign="Left" />
                        </dx:GridViewCommandColumn>


                        <dx:GridViewCommandColumn ShowEditButton="true" ShowDeleteButton="false" VisibleIndex="1" ButtonRenderMode="Image">
                            <CustomButtons>
                                <dx:GridViewCommandColumnCustomButton ID="deleteButton">
                                    <Image IconID="edit_delete_16x16" />
                                </dx:GridViewCommandColumnCustomButton>
                            </CustomButtons>
                        </dx:GridViewCommandColumn>


                        <dx:GridViewDataTextColumn FieldName="ID" Visible="false"></dx:GridViewDataTextColumn>

                        <dx:GridViewDataTextColumn Caption="Nome" FieldName="NOME">
                            <PropertiesTextEdit>
                                <ValidationSettings
                                    Display="Dynamic"
                                    EnableCustomValidation="true">
                                    <RegularExpression ValidationExpression="^[A-Za-z\s]+$" ErrorText="O campo Nome deve conter apenas letras." />
                                    <RequiredField IsRequired="true" ErrorText="Campo obrigatório" />
                                </ValidationSettings>
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataTextColumn Caption="CPF" FieldName="CPF">
                            <PropertiesTextEdit>
                                <ValidationSettings
                                    Display="Dynamic"
                                    EnableCustomValidation="true">
                                    <RequiredField IsRequired="true" ErrorText="Campo obrigatório" />
                                </ValidationSettings>
                                <MaskSettings Mask="000\.000\.000-00" />
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataTextColumn Caption="E-mail" FieldName="EMAIL">
                            <PropertiesTextEdit>
                                <ValidationSettings
                                    Display="Dynamic"
                                    EnableCustomValidation="true">
                                    <RegularExpression
                                        ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                                        ErrorText="Por favor, insira um endereço de email válido." />
                                    <RequiredField IsRequired="true" ErrorText="Campo obrigatório" />
                                </ValidationSettings>
                            </PropertiesTextEdit>


                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataDateColumn Caption="Data de Nascimento" FieldName="DATANASCIMENTO">
                            <PropertiesDateEdit UseMaskBehavior="true" EditFormatString="dd/MM/yyyy">
                                <ValidationSettings
                                    Display="Dynamic"
                                    EnableCustomValidation="true">
                                    <RequiredField IsRequired="true" ErrorText="Campo obrigatório" />
                                </ValidationSettings>
                            </PropertiesDateEdit>
                        </dx:GridViewDataDateColumn>

                        <dx:GridViewDataComboBoxColumn FieldName="GENERO" Caption="Genero">
                            <PropertiesComboBox DataSourceID="odsGenero"
                                ValueType="System.Int32"
                                ValueField="Value"
                                TextField="Name" />
                        </dx:GridViewDataComboBoxColumn>

                        <dx:GridViewDataTextColumn Caption="Celular" FieldName="CELULAR">
                            <PropertiesTextEdit>
                                <ValidationSettings
                                    Display="Dynamic"
                                    EnableCustomValidation="true">
                                    <RequiredField IsRequired="true" ErrorText="O CPF é obrigatório." />
                                </ValidationSettings>
                                <MaskSettings Mask="(00) 00000-0000" />

                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataTextColumn Caption="Senha" FieldName="SENHA">
                            <PropertiesTextEdit>
                                <ValidationSettings
                                    Display="Dynamic"
                                    EnableCustomValidation="true">
                                    <RequiredField IsRequired="true" ErrorText="Campo obrigatório" />
                                </ValidationSettings>
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataComboBoxColumn FieldName="STATUS" Caption="Status" PropertiesComboBox-DataSourceID="odsStatus">
                            <PropertiesComboBox ValueField="Value" ValueType="System.Int32" TextField="Name" />
                        </dx:GridViewDataComboBoxColumn>

                    </Columns>


                </dx:ASPxGridView>
                <%-- GRIDVIEW FIM --%>


                <%-- FORMULARIO DE DELEÇÃO INICIO --%>
                <dx:ASPxRoundPanel
                    runat="server"
                    ID="panelDelete"
                    ClientInstanceName="panelDelete"
                    HeaderText=""
                    HeaderContent-BackColor="Transparent"
                    Width="100%"
                    BackColor="Transparent"
                    ShowHeader="false"
                    EnableViewState="false"
                    Visible="false">
                    <Border BorderColor="Transparent" BorderStyle="None" />
                    <ContentPaddings Padding="0px" PaddingBottom="10px" PaddingLeft="0px" PaddingRight="0px" PaddingTop="25px" />

                    <HeaderContent BackColor="Transparent" />
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxFormLayout runat="server" ID="deleteForm" RequiredMarkDisplayMode="RequiredOnly"
                                EnableViewState="false" EncodeHtml="false" UseDefaultPaddings="true" Width="100%" AllowCollapsingByHeaderClick="true">
                                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="800" />
                                <Items>
                                    <dx:LayoutGroup Caption="" ColCount="2" SettingsItemHelpTexts-Position="Bottom" GroupBoxDecoration="none" Width="100%">
                                        <Items>
                                            <dx:LayoutItem Caption="Usuario responsável" Width="100%">
                                                <CaptionStyle Font-Bold="true" />
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>

                                                        <dx:ASPxTextBox
                                                            runat="server"
                                                            ID="usuarioReponsavel"
                                                            ClientInstanceName="usuarioResponsavel">
                                                            <ValidationSettings>
                                                                <RequiredField IsRequired="true" ErrorText="Campo obrigatório" />
                                                            </ValidationSettings>

                                                        </dx:ASPxTextBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                            <dx:LayoutItem Caption="Motivo da exclusão:" Width="100%">
                                                <CaptionStyle Font-Bold="true" />
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>

                                                        <dx:ASPxTextBox
                                                            runat="server"
                                                            ID="motivoExclusao"
                                                            ClientInstanceName="motivoExclusao">
                                                            <ValidationSettings>
                                                                <RequiredField IsRequired="true" ErrorText="Campo obrigatório" />
                                                            </ValidationSettings>

                                                        </dx:ASPxTextBox>

                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                        </Items>

                                        <SettingsItemHelpTexts Position="Bottom" />
                                    </dx:LayoutGroup>
                                </Items>
                            </dx:ASPxFormLayout>

                            <br />
                            <div style="display: flex; justify-content: flex-end; padding-right: 65px;">
                                <dx:ASPxButton
                                    runat="server"
                                    ID="btnConfirmarDelecao"
                                    ClientInstanceName="confirmarDelecao"
                                    Text="Confirmar"
                                    HorizontalAlign="Center">
                                    <ClientSideEvents Click="function(s, e) { Callback_Delecao(s, 'ConfirmarDelecao'); }" />
                                </dx:ASPxButton>

                                <dx:ASPxButton
                                    runat="server"
                                    ID="btnCancelarDelecao"
                                    ClientInstanceName="cancelarDelecao"
                                    Text="Cancelar"
                                    HorizontalAlign="Center">
                                    <ClientSideEvents Click="function(s, e) { Callback_Delecao(s, 'CancelarDelecao'); }" />
                                </dx:ASPxButton>
                            </div>
                            <br />
                        </dx:PanelContent>
                    </PanelCollection>

                </dx:ASPxRoundPanel>
                <%-- FORMULARIO DE DELEÇÃO FIM --%>


                <%-- FORMULARIO DE CRIACAO INICIO --%>
                <dx:ASPxRoundPanel
                    runat="server"
                    ID="CreatePanel"
                    ClientInstanceName="CreatePanel"
                    HeaderText=""
                    HeaderContent-BackColor="Transparent"
                    Width="100%"
                    BackColor="Transparent"
                    ShowHeader="false"
                    EnableViewState="false"
                    Visible="false"
                    >
                    <Border BorderColor="Transparent" BorderStyle="None" />
                    <ContentPaddings Padding="0px" PaddingBottom="10px" PaddingLeft="0px" PaddingRight="0px" PaddingTop="25px" />

                    <HeaderContent BackColor="Transparent" />
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxFormLayout 
                                runat="server" 
                                ID="createForm" 
                                RequiredMarkDisplayMode="RequiredOnly"
                                EncodeHtml="false" 
                                UseDefaultPaddings="true" 
                                Width="100%" 
                                AllowCollapsingByHeaderClick="true"
                                EnableViewState="false" 
                                >



                                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="800" />
                                <Items>
                                    <dx:LayoutGroup  ColCount="2" ColumnCount="2" SettingsItemHelpTexts-Position="Bottom" GroupBoxDecoration="none" Width="100%">
                                        <Items>
                                            <dx:LayoutItem Caption="Nome" Width="50%">
                                                <CaptionStyle Font-Bold="true" />
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>

                                                        <dx:ASPxTextBox
                                                            runat="server"
                                                            ID="nomePessoaFisica"
                                                            ClientInstanceName="nomePessoaFisica">
                                                            <ValidationSettings
                                                                Display="Dynamic"
                                                                EnableCustomValidation="true">
                                                                <RegularExpression ValidationExpression="^[A-Za-z\s]+$" ErrorText="O campo Nome deve conter apenas letras." />
                                                                <RequiredField IsRequired="true" ErrorText="Campo obrigatório" />
                                                            </ValidationSettings>

                                                        </dx:ASPxTextBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                            <dx:LayoutItem Caption="CPF:" Width="50%">
                                                <CaptionStyle Font-Bold="true" />
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>

                                                        <dx:ASPxTextBox
                                                            runat="server"
                                                            ID="cpfPessoaFisica"
                                                            ClientInstanceName="cpfPessoaFisica">
                                                            <ValidationSettings
                                                                Display="Dynamic"
                                                                EnableCustomValidation="true">
                                                                <RequiredField IsRequired="true" ErrorText="Campo obrigatório" />
                                                            </ValidationSettings>
                                                            <MaskSettings Mask="000\.000\.000-00" />
                                                        </dx:ASPxTextBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                            <dx:LayoutItem Caption="E-mail:" Width="50%">
                                                <CaptionStyle Font-Bold="true" />
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>

                                                        <dx:ASPxTextBox
                                                            runat="server"
                                                            ID="emailPessoaFisica"
                                                            ClientInstanceName="emailPessoaFisica">
                                                            <ValidationSettings
                                                                Display="Dynamic"
                                                                EnableCustomValidation="true">
                                                                <RegularExpression
                                                                    ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                                                                    ErrorText="Por favor, insira um endereço de email válido." />
                                                                <RequiredField IsRequired="true" ErrorText="Campo obrigatório" />
                                                            </ValidationSettings>

                                                        </dx:ASPxTextBox>

                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                            <dx:LayoutItem Caption="Data de Nascimento: " Width="50%">
                                                <CaptionStyle Font-Bold="true" />
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>

                                                        <dx:ASPxDateEdit    
                                                            runat="server"
                                                            ID="DataNasc"
                                                            ClientInstanceName="DataNasc" 
                                                            UseMaskBehavior="true"
                                                            EditFormatString="dd/MM/yyyy">
                                                            <ValidationSettings
                                                                Display="Dynamic"
                                                                EnableCustomValidation="true">
                                                                <RequiredField IsRequired="true" ErrorText="Campo obrigatório" />
                                                            </ValidationSettings>

                                                        </dx:ASPxDateEdit>

                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                            <dx:LayoutItem Caption="Genero" Width="50%">
                                                <CaptionStyle Font-Bold="true" />
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>

                                                        <dx:ASPxComboBox
                                                            ID="cbGenero"
                                                            runat="server"
                                                            DataSourceID="odsGenero"
                                                            ValueField="Value"
                                                            TextField="Name">
                                                        </dx:ASPxComboBox>


                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                            <dx:LayoutItem Caption="Celular" Width="50%">
                                                <CaptionStyle Font-Bold="true" />
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>

                                                        <dx:ASPxTextBox
                                                            runat="server"
                                                            ID="celularPessoaFisica"
                                                            ClientInstanceName="celularPessoaFisica">
                                                            <ValidationSettings>
                                                                <RequiredField IsRequired="true" ErrorText="Campo obrigatório" />
                                                            </ValidationSettings>
                                                            <MaskSettings Mask="(00) 00000-0000" />

                                                        </dx:ASPxTextBox>

                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                            <dx:LayoutItem Caption="Senha" Width="50%">
                                                <CaptionStyle Font-Bold="true" />
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>

                                                        <dx:ASPxTextBox
                                                            runat="server"
                                                            ID="senhaPessoaFisica"
                                                            ClientInstanceName="senhaPessoaFisica">
                                                            <ValidationSettings>
                                                                <RequiredField IsRequired="true" ErrorText="Campo obrigatório" />
                                                            </ValidationSettings>

                                                        </dx:ASPxTextBox>

                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                        </Items>

                                        <SettingsItemHelpTexts Position="Bottom" />
                                    </dx:LayoutGroup>
                                </Items>
                            </dx:ASPxFormLayout>

                            <br />
                            <div style="display: flex; justify-content: flex-end; padding-right: 65px;">
                                <dx:ASPxButton
                                    runat="server"
                                    ID="btnCreatePessoaFisica"
                                    ClientInstanceName="btnCreatePessoaFisica"
                                    Text="Confirmar"
                                    HorizontalAlign="Center">
                                    <ClientSideEvents Click="function(s, e) { Callback_Criacao(s, 'ConfirmarCriacao'); }" />
                                </dx:ASPxButton>

                                <dx:ASPxButton
                                    runat="server"
                                    ID="btnCancelPessoaFisica"
                                    ClientInstanceName="btnCancelPessoaFisica"
                                    Text="Cancelar"
                                    HorizontalAlign="Center">
                                    <ClientSideEvents Click="function(s, e) { Callback_Criacao(s, 'CancelarCriacao'); }" />
                                </dx:ASPxButton>
                            </div>
                            <br />
                        </dx:PanelContent>
                    </PanelCollection>

                </dx:ASPxRoundPanel>
                <%-- FORMULARIO DE CRIACAO FIM --%>

                <%-- GRIDVIEW DEPENDENTES INICIO --%>
                 <dx:ASPxMenu
                    runat="server"
                    ClientInstanceName="AddDependente"
                    ShowAsToolbar="true"
                    ShowPopOutImages="true"
                    Theme="Office2010Blue"
                    ID="AddDependente"
                    ClientVisible="false">
                    <Items>
                        <dx:MenuItem Text="Adicionar" Name="ADICIONAR">
                            <Image IconID="actions_insert_16x16"></Image>
                        </dx:MenuItem>
                    </Items>
                    <ClientSideEvents ItemClick="onClickAdd" />
                </dx:ASPxMenu>

                <dx:ASPxGridView
                    ID="DependentesGrid"
                    ClientInstanceName="DependentesGrid"
                    DataSourceID="odsDependentes"
                    runat="server"
                    Theme="Office2010Blue"
                    Width="100%"
                    KeyFieldName="id"
                    OnRowInserting="DependentesGrid_RowInserting1"
                    OnRowInserted="DependentesGrid_RowInserted"
                    OnRowUpdating="DependentesGrid_RowUpdating"
                    OnRowUpdated="DependentesGrid_RowUpdated"
                    OnRowDeleting="DependentesGrid_RowDeleting"
                    OnRowDeleted="DependentesGrid_RowDeleted"
                    ClientVisible="false">

                    <EditFormLayoutProperties
                        ColumnCount="2">

                        <Items>

                            <dx:GridViewColumnLayoutItem ColumnName="Nome" Caption="Nome:" Visible="true" />
                            <dx:GridViewColumnLayoutItem ColumnName="Cpf" Caption="CPF:" Visible="true" />
                            <dx:GridViewColumnLayoutItem ColumnName="DataDeNascimento" Caption="Data de Nascimento:" Visible="true" />
                            <dx:GridViewColumnLayoutItem ColumnName="Email" Caption="E-mail:" Visible="true" />
                            <dx:GridViewColumnLayoutItem ColumnName="Celular" Caption="Telefone:" Visible="true" />
                            <dx:GridViewColumnLayoutItem ColumnName="Genero" Caption="Genero:" Visible="true" />
                            <dx:GridViewColumnLayoutItem ColumnName="Status" Caption="Status:" Visible="false" />

                            <dx:EditModeCommandLayoutItem HorizontalAlign="Right" ShowUpdateButton="true" ShowCancelButton="true" />
                        </Items>
                    </EditFormLayoutProperties>

                    <ClientSideEvents CustomButtonClick="onButtonClick" />
                    <SettingsDataSecurity
                        AllowDelete="True"
                        AllowEdit="True"
                        AllowInsert="True" />
                    <SettingsPopup>
                        <HeaderFilter MinHeight="140px"></HeaderFilter>
                    </SettingsPopup>
                   
                    <SettingsCommandButton>

                        <EditButton ButtonType="Image">
                            <Image
                                ToolTip="Editar"
                                IconID="edit_edit_16x16">
                            </Image>
                        </EditButton>

                        <DeleteButton ButtonType="Image">
                            <Image
                                ToolTip="Excluir"
                                IconID="edit_delete_16x16">
                            </Image>
                        </DeleteButton>

                        <UpdateButton
                            ButtonType="Button"
                            Text="Confirmar">
                            <Image IconID="actions_apply_16x16"></Image>
                        </UpdateButton>

                        <CancelButton
                            ButtonType="Button"
                            Text="Cancelar">
                            <Image IconID="actions_cancel_16x16"></Image>
                        </CancelButton>
                    </SettingsCommandButton>

                    <Columns>
                        <dx:GridViewCommandColumn ButtonRenderMode="Image" ShowEditButton="true" ShowDeleteButton="true"></dx:GridViewCommandColumn>

                        <dx:GridViewDataTextColumn FieldName="id" Visible="false"></dx:GridViewDataTextColumn>

                        <dx:GridViewDataTextColumn ReadOnly="false" Caption="Nome" FieldName="Nome">
                            <PropertiesTextEdit>
                                <ValidationSettings
                                    Display="Dynamic"
                                    EnableCustomValidation="True">
                                    <RequiredField IsRequired="true" ErrorText=" Campo Obrigatório*" />
                                </ValidationSettings>
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataTextColumn Caption="Cpf:" FieldName="Cpf">
                            <PropertiesTextEdit>
                                <ValidationSettings
                                    Display="Dynamic"
                                    EnableCustomValidation="True">
                                    <RequiredField IsRequired="true" ErrorText=" Campo Obrigatório*" />
                                </ValidationSettings>
                                <MaskSettings Mask="000\.000\.000-00" />
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataDateColumn Caption="Data" FieldName="DataDeNascimento">
                            <PropertiesDateEdit UseMaskBehavior="true" EditFormatString="dd/MM/yyyy">
                                <ValidationSettings
                                    Display="Dynamic"
                                    EnableCustomValidation="true">
                                    <RequiredField IsRequired="true" ErrorText="Campo obrigatório" />
                                </ValidationSettings>
                            </PropertiesDateEdit>
                        </dx:GridViewDataDateColumn>

                        <dx:GridViewDataTextColumn Caption="E-mail" FieldName="Email">
                                 <PropertiesTextEdit>
                                <ValidationSettings
                                    Display="Dynamic"
                                    EnableCustomValidation="true">
                                    <RegularExpression
                                        ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                                        ErrorText="Por favor, insira um endereço de email válido." />
                                    <RequiredField IsRequired="true" ErrorText="Campo obrigatório" />
                                </ValidationSettings>
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataTextColumn Caption="Telefone" FieldName="Celular">
                            <PropertiesTextEdit>
                                <ValidationSettings
                                    Display="Dynamic"
                                    EnableCustomValidation="true">
                                    <RequiredField IsRequired="true" ErrorText="O CPF é obrigatório." />
                                </ValidationSettings>
                                <MaskSettings Mask="(00) 00000-0000" />
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataComboBoxColumn FieldName="Genero" Caption="Genero">
                            <PropertiesComboBox DataSourceID="odsGenero"
                                ValueType="System.Int32"
                                ValueField="Value"
                                TextField="Name" />
                        </dx:GridViewDataComboBoxColumn>

                        <dx:GridViewDataComboBoxColumn FieldName="Status" PropertiesComboBox-DataSourceID="odsStatus">
                            <PropertiesComboBox
                                ValueField="Value"
                                ValueType="System.Int32"
                                TextField="Name">
                            </PropertiesComboBox>
                        </dx:GridViewDataComboBoxColumn>
                    </Columns>
                </dx:ASPxGridView>
               <%--=============GRID VIEW DEPENDENTE FIM===========--%>


            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>

    <asp:SqlDataSource
        runat="server"
        ID="SqlPessoa"
        OnInit="SqlPessoa_Init"
        ProviderName="System.Data.SqlClient"
        ConnectionString="<%$ ConnectionStrings:iPortSolutionsSqlServerContext %>"></asp:SqlDataSource>

   <%-- <asp:SqlDataSource
        runat="server"
        ID="SqlDependente"
        OnInit="SqlDependente_Init"
        ProviderName="System.Data.SqlClient"
        ConnectionString="<%$ ConnectionStrings:iPortSolutionsSqlServerContext %>"></asp:SqlDataSource>--%>

    <asp:ObjectDataSource
        runat="server"
        ID="odsGenero"
        SelectMethod="GetAllGenders"
        TypeName="DXWebApplication1.Default"></asp:ObjectDataSource>

        <asp:ObjectDataSource
        runat="server"
        ID="odsDependentes"
        SelectMethod="GetAllDependentes"
        TypeName="DXWebApplication1.Default"></asp:ObjectDataSource>

    <asp:ObjectDataSource
        runat="server"
        ID="odsStatus"
        SelectMethod="GetAllStatus"
        TypeName="DXWebApplication1.Default"></asp:ObjectDataSource>

</asp:Content>
