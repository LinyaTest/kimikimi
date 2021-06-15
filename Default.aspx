<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
        <style type="text/css">
        .style1
        {
            width: 49%;
            border-style: solid;
            border-width: 1px;
        }
        .style5
        {
            width: 68px;
        }
        .style4
        {
            width: 91px;
        }
        .style3
        {
            width: 25px;
        }
            #form1 {
                height: 441px;
            }
            .auto-style1 {
                width: 68px;
                height: 31px;
            }
            .auto-style2 {
                height: 31px;
            }
        </style>
</head>
<body style="height: 712px">
    <form id="form1" runat="server">
        <table class="style1" dir="ltr">
            <tr>
                <td colspan="3" style="text-align: center">
                    查詢傳票調閱紀錄</td>
            </tr>
            <tr>
                <td class="style4">
                    傳票號碼</td>
                <td class="style4">
                    &nbsp;</td>
                <td class="style3">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style1">
                    <asp:TextBox ID="TextBox1" runat="server" Width="243px">TA1000421001</asp:TextBox>
                </td>
                <td class="auto-style2">
                    <asp:Button ID="Button1" runat="server" Text="查詢" Width="63px" OnClick="Button1_Click2" />
                </td>
                <td class="auto-style2"></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:CHACC_LITConnectionString2 %>" 
            SelectCommand="SELECT * FROM [Lead_trsno] WHERE ([trsno] = @trsno)" 
            UpdateCommand="UPDATE [Lead_trsno] SET [lead_pno] = @lead_pno, [lead_date] = @lead_date, [return_date] = @return_date, [remarks] = @remarks, [login_pno] = @login_pno, [login_date] = @login_date WHERE [trsno] = @trsno" 
            DeleteCommand="DELETE FROM [Lead_trsno] WHERE [trsno] = @trsno" InsertCommand="INSERT INTO [Lead_trsno] ([lead_pno], [trsno], [lead_date], [return_date], [remarks], [login_pno], [login_date]) VALUES (@lead_pno, @trsno, @lead_date, @return_date, @remarks, @login_pno, @login_date)">
            <DeleteParameters>
                <asp:Parameter Name="trsno" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="lead_pno" Type="String" />
                <asp:Parameter Name="trsno" Type="String" />
                <asp:Parameter Name="lead_date" Type="DateTime" />
                <asp:Parameter Name="return_date" Type="DateTime" />
                <asp:Parameter Name="remarks" Type="String" />
                <asp:Parameter Name="login_pno" Type="String" />
                <asp:Parameter Name="login_date" Type="DateTime" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="TextBox1" Name="trsno" PropertyName="Text" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="lead_pno" Type="String" />
                <asp:Parameter Name="trsno" Type="String" />
                <asp:Parameter Name="lead_date" Type="Datetime" />
                <asp:Parameter Name="return_date" Type="Datetime" />
                <asp:Parameter Name="remarks" Type="String" />
                <asp:Parameter Name="login_pno" Type="String" />
                <asp:Parameter Name="login_date" Type="Datetime" />
                <asp:Parameter Name="id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GridView3" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                <asp:BoundField DataField="lead_pno" HeaderText="lead_pno" SortExpression="lead_pno" />
                <asp:BoundField DataField="trsno" HeaderText="trsno" SortExpression="trsno" />
                <asp:BoundField DataField="lead_date" HeaderText="lead_date" SortExpression="lead_date" HtmlEncode="False" DataFormatString="{0:yyyy/mm/dd}" />
                <asp:BoundField DataField="return_date" HeaderText="return_date" SortExpression="return_date" ApplyFormatInEditMode="True" DataFormatString="{0:yyyy/mm/dd}" HtmlEncode="False" />
                <asp:BoundField DataField="remarks" HeaderText="remarks" SortExpression="remarks" />
                <asp:BoundField DataField="login_pno" HeaderText="login_pno" SortExpression="login_pno" />
                <asp:BoundField DataField="login_date" HeaderText="login_date" SortExpression="login_date" HtmlEncode="False" ApplyFormatInEditMode="True" DataFormatString="{0:yyyy/mm/dd}" />
                <asp:CommandField InsertVisible="False" ShowEditButton="True" />
            </Columns>
        </asp:GridView>
        <br />
        <br />
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:CHACC_LITConnectionString2 %>" 
            SelectCommand="SELECT * FROM [Lead_trsno2] WHERE ([trsno] = @trsno)" DeleteCommand="DELETE FROM [Lead_trsno2] WHERE [id] = @id" InsertCommand="INSERT INTO [Lead_trsno2] ([lead_pno], [trsno], [lead_date], [return_date], [remarks], [login_pno], [login_date]) VALUES (@lead_pno, @trsno, @lead_date, @return_date, @remarks, @login_pno, @login_date)" UpdateCommand="UPDATE [Lead_trsno2] SET [lead_pno] = @lead_pno, [trsno] = @trsno, [lead_date] = @lead_date, [return_date] = @return_date, [remarks] = @remarks, [login_pno] = @login_pno, [login_date] = @login_date WHERE [id] = @id">
            <DeleteParameters>
                <asp:Parameter Name="id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="lead_pno" Type="String" />
                <asp:Parameter Name="trsno" Type="String" />
                <asp:Parameter DbType="Date" Name="lead_date" />
                <asp:Parameter DbType="Date" Name="return_date" />
                <asp:Parameter Name="remarks" Type="String" />
                <asp:Parameter Name="login_pno" Type="String" />
                <asp:Parameter DbType="Date" Name="login_date" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="TextBox1" Name="trsno" PropertyName="Text" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="lead_pno" Type="String" />
                <asp:Parameter Name="trsno" Type="String" />
                <asp:Parameter DbType="Date" Name="lead_date" />
                <asp:Parameter DbType="Date" Name="return_date" />
                <asp:Parameter Name="remarks" Type="String" />
                <asp:Parameter Name="login_pno" Type="String" />
                <asp:Parameter DbType="Date" Name="login_date" />
                <asp:Parameter Name="id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource2" Visible="False">
        <EmptyDataTemplate>
            Sorry...No Records!!
        </EmptyDataTemplate>
        <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
        <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
            <Columns>
                <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                <asp:BoundField DataField="lead_pno" HeaderText="lead_pno" SortExpression="lead_pno" />
                <asp:BoundField DataField="trsno" HeaderText="trsno" SortExpression="trsno" />
                <asp:BoundField DataField="lead_date" HeaderText="lead_date" SortExpression="lead_date" />
                <asp:BoundField DataField="return_date" HeaderText="return_date" SortExpression="return_date" />
                <asp:BoundField DataField="remarks" HeaderText="remarks" SortExpression="remarks" />
                <asp:BoundField DataField="login_pno" HeaderText="login_pno" SortExpression="login_pno" />
                <asp:BoundField DataField="login_date" HeaderText="login_date" SortExpression="login_date" />
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
