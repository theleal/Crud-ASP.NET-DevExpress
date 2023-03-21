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
                ASPxGridView1.AddNewRow();
                e.processoOnServer = false;
            }
        }

    </script>

    <dx:ASPxCallbackPanel
        runat="server"
        ID="CallbackPanel"
        ClientInstanceName="CallbackPanel"
        RenderMode="Div"
        OnCallback="CallbackPanel_Callback">
        <SettingsLoadingPanel Text="Carregando&amp;hellip;" />
        <PanelCollection>
            <dx:PanelContent runat="server">
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
                    <ContentPaddings Padding="0px" PaddingBottom="0px" PaddingLeft="0px" PaddingRight="0px" PaddingTop="0px" />
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <dx:ASPxFormLayout runat="server" ID="layoutFormulario" RequiredMarkDisplayMode="RequiredOnly"
                                EnableViewState="false" EncodeHtml="false" UseDefaultPaddings="false" Width="100%" AllowCollapsingByHeaderClick="true">
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
                                    </dx:LayoutGroup>
                                </Items>
                            </dx:ASPxFormLayout>

                            <br />

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
                        </dx:PanelContent>
                    </PanelCollection>

                </dx:ASPxRoundPanel>

                <dx:ASPxMenu
                    runat="server"
                    ClientInstanceName="Menu"
                    ShowAsToolbar="true"
                    ShowPopOutImages="true"
                    Theme="Office2010Blue"
                    id="Menu">
                    <Items>
                        <dx:MenuItem Text="Criar" Name="CRIAR">
                            <image IconID="actions_insert_16x16"></image>
                        </dx:MenuItem>
                    </Items>
                    <ClientSideEvents ItemClick="onClickMenu"/>
                </dx:ASPxMenu>


                <dx:ASPxGridView
                    ID="ASPxGridView1"
                    ClientInstanceName="ASPxGridView1"
                    OnRowInserting="ASPxGridView1_RowInserting"
                    OnRowInserted="ASPxGridView1_RowInserted"
                    DataSourceID="SqlPessoa"
                    runat="server"
                    Theme="Office2010Blue"
                    Width="100%"
                    KeyFieldName="ID">


                    <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="True" />

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
                        <dx:GridViewDataTextColumn FieldName="ID" Visible="false"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Nome" FieldName="NOME"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="CPF" FieldName="CPF"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="E-mail" FieldName="EMAIL"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn Caption="Data de Nascimento" FieldName="DATANASCIMENTO"></dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn Caption="Genero" FieldName="GENERO"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Celular" FieldName="CELULAR"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Senha" FieldName="SENHA"></dx:GridViewDataTextColumn>

                        
                    </Columns>
                </dx:ASPxGridView>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>

    <asp:SqlDataSource
        runat="server"
        ID="SqlPessoa"
        OnInit="SqlPessoa_Init"
        ProviderName="System.Data.SqlClient"
        OnSelecting="SqlPessoa_Selecting"
        ConnectionString="<%$ ConnectionStrings:iPortSolutionsSqlServerContext %>"></asp:SqlDataSource>




</asp:Content>
