<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
            background-color: #FFFF99;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <table class="auto-style1">
            <tr>
                <td>請選擇年度</td>
                <td>選擇月份</td>
                <td>選擇傳票號碼</td>
            </tr>
            <tr>
                <td>
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="years" DataValueField="years" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AppendDataBoundItems="True">
            <asp:ListItem Value="0">==請選擇==</asp:ListItem>
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CHACC_LITConnectionString %>" SelectCommand="select DISTINCT years from TBTRS ORDER BY years desc"></asp:SqlDataSource>
                </td>
                <td>
        <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataTextField="month" DataValueField="month" AppendDataBoundItems="True" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CHACC_LITConnectionString %>" SelectCommand="SELECT DISTINCT SUBSTRING(RIGHT (trsno, 7), 1, 2) AS month FROM TBTRS WHERE (years = @years) ORDER BY month DESC">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="years" PropertyName="SelectedValue" DefaultValue="94" />
            </SelectParameters>
        </asp:SqlDataSource>
                </td>
                <td>
        <asp:DropDownList ID="DropDownList3" runat="server" AutoPostBack="True" DataTextField="trsno" DataValueField="trsno" AppendDataBoundItems="True" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged" Width="191px" Height="16px">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CHACC_LITConnectionString %>" SelectCommand="SELECT trsno FROM TBTRS WHERE (years = @years) AND (SUBSTRING(RIGHT (trsno, 7), 1, 2) = @month)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="years" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownList2" Name="month" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
                </td>
            </tr>
        </table>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None">
            <AlternatingRowStyle BackColor="PaleGoldenrod" />
            <EmptyDataTemplate>
                無歷史紀錄。
            </EmptyDataTemplate>
            <FooterStyle BackColor="Tan" />
            <HeaderStyle BackColor="Tan" Font-Bold="True" />
            <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
            <SortedAscendingCellStyle BackColor="#FAFAE7" />
            <SortedAscendingHeaderStyle BackColor="#DAC09E" />
            <SortedDescendingCellStyle BackColor="#E1DB9C" />
            <SortedDescendingHeaderStyle BackColor="#C2A47B" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:CHACC_LITConnectionString %>" SelectCommand="SELECT * FROM [Lead_trsno1] WHERE ([trsno] = @trsno)
and return_date is not null">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList3" Name="trsno" PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        
        <asp:GridView ID="GridView2" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ShowEditButton="True" />
                <asp:CommandField ShowDeleteButton="True" />
            </Columns>
            <EditRowStyle BackColor="#7C6F57" />
            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#E3EAEB" />
            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F8FAFA" />
            <SortedAscendingHeaderStyle BackColor="#246B61" />
            <SortedDescendingCellStyle BackColor="#D4DFE1" />
            <SortedDescendingHeaderStyle BackColor="#15524A" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:CHACC_LITConnectionString %>" 
            SelectCommand="SELECT * FROM [Lead_trsno1] where trsno=@trsno
and return_date is null" 
            DeleteCommand="DELETE FROM [Lead_trsno1] WHERE [id] = @id" 
            InsertCommand="INSERT INTO [Lead_trsno1] ([lead_pno], [trsno], [lead_date], [return_date], [remarks], [login_pno], [login_date]) VALUES (@lead_pno, @trsno, @lead_date, @return_date, @remarks, @login_pno, @login_date)" 
            UpdateCommand="UPDATE [Lead_trsno1] SET [lead_pno] = @lead_pno, [trsno] = @trsno, [lead_date] = @lead_date, [return_date] = @return_date, [remarks] = @remarks, [login_pno] = @login_pno, [login_date] = @login_date WHERE [id] = @id">
            <DeleteParameters>
                <asp:Parameter Name="id" Type="Int32" />
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
                <asp:ControlParameter ControlID="DropDownList3" Name="trsno" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="lead_pno" Type="String" />
                <asp:Parameter Name="trsno" Type="String" />
                <asp:Parameter Name="lead_date" Type="DateTime" />
                <asp:Parameter Name="return_date" Type="DateTime" />
                <asp:Parameter Name="remarks" Type="String" />
                <asp:Parameter Name="login_pno" Type="String" />
                <asp:Parameter Name="login_date" Type="DateTime" />
                <asp:Parameter Name="id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
    </form>
</body>
</html>
