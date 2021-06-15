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
                height: 75px;
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
            .auto-style3 {
                height: 31px;
                width: 25px;
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
                    <asp:TextBox ID="TextBox1" runat="server" Width="224px" Font-Bold="True" Font-Size="Large" Height="52px">TA1000421001</asp:TextBox>
                </td>
                <td class="auto-style2">
                    <asp:Button ID="Button1" runat="server" Text="查詢" Width="73px" OnClick="Button1_Click2" Font-Bold="True" Font-Size="Large" Height="54px" />
                </td>
                <td class="auto-style3"></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td class="style3">&nbsp;</td>
            </tr>
        </table>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:CHACC_LITConnectionString %>" 
            SelectCommand="SELECT * FROM [Lead_trsno2] WHERE ([trsno] = @trsno)" 
            UpdateCommand="UPDATE [Lead_trsno2] SET [lead_pno] = @lead_pno, [lead_date] = @lead_date, [return_date] = @return_date, [remarks] = @remarks, [login_pno] = @login_pno, [login_date] = @login_date WHERE [trsno] = @trsno" 
            DeleteCommand="DELETE FROM [Lead_trsno2] WHERE [trsno] = @trsno" InsertCommand="INSERT INTO [Lead_trsno2] ([lead_pno], [trsno], [lead_date], [return_date], [remarks], [login_pno], [login_date]) VALUES (@lead_pno, @trsno, @lead_date, @return_date, @remarks, @login_pno, @login_date)">
            <DeleteParameters>
                <asp:Parameter Name="trsno" Type="String" />
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
                <asp:Parameter DbType="Date" Name="lead_date" />
                <asp:Parameter DbType="Date" Name="return_date" />
                <asp:Parameter Name="remarks" Type="String" />
                <asp:Parameter Name="login_pno" Type="String" />
                <asp:Parameter DbType="Date" Name="login_date" />
                <asp:Parameter Name="trsno" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="trsno" DataSourceID="SqlDataSource1" Height="99px" CellPadding="4" ForeColor="#333333" GridLines="None" Width="868px">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowEditButton="True" />
                <asp:TemplateField HeaderText="借用人" SortExpression="lead_pno">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("lead_pno") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("lead_pno") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="trsno" HeaderText="傳票號碼" ReadOnly="True" SortExpression="trsno" />
                <asp:TemplateField HeaderText="借出日" SortExpression="lead_date">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Height="47px" Text='<%# Bind("lead_date", "{0:yyyy-MM-dd}") %>' TextMode="Date" Width="254px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("lead_date", "{0: yyyy-MM-dd}") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="歸還日" SortExpression="return_date">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("return_date", "{0:yyyy-MM-dd}") %>' TextMode="Date"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("return_date", "{0: yyyy-MM-dd}") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="remarks" HeaderText="註記" SortExpression="remarks" />
                <asp:BoundField DataField="login_pno" HeaderText="login_pno" SortExpression="login_pno" Visible="False" />
                <asp:TemplateField HeaderText="login_date" SortExpression="login_date" Visible="False">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("login_date", "{0:yyyy-MM-dd}") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("login_date", "{0: yyyy-MM-dd}") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
    </form>
</body>
</html>
