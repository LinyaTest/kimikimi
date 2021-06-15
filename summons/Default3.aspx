<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default3.aspx.cs" Inherits="Default3" %>

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
                height: 582px;
            }
            .auto-style1 {
                width: 68px;
                height: 31px;
            }
            .auto-style2 {
                height: 31px;
            }
            .auto-style3 {
                height: 521px;
                width: 864px;
            }
            .auto-style4 {
                height: 31px;
                width: 25px;
            }
            .auto-style5 {
                width: 99%;
                height: 184px;
                background-color: #FFFF99;
            }
            .auto-style6 {
                height: 27px;
            }
            .auto-style8 {
                height: 27px;
                width: 239px;
            }
            .新增樣式1 {
                width: 100px;
            }
            .auto-style10 {
                width: 239px;
            }
            </style>
</head>
<body style="height: 712px">
    <form id="form1" runat="server" class="auto-style3">
        <table class="style1" dir="ltr">
            <tr>
                <td colspan="4" style="text-align: center">
                    查詢傳票調閱紀錄</td>
            </tr>
            <tr>
                <td class="style4">
                    傳票年</td>
                <td class="style4">
                    月份</td>
                <td class="style4">
                    號碼</td>
                <td class="style3">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:DropDownList ID="DropDownList2" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="years" DataValueField="years" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged">
                        <asp:ListItem Value="0">請選擇 --</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="auto-style2">
                    <asp:DropDownList ID="DropDownList3" runat="server" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged" AutoPostBack="True" DataTextField="a" DataValueField="a" Height="18px">
                        <asp:ListItem Value="0">請選擇--</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="auto-style1">
                    <asp:DropDownList ID="DropDownList4" runat="server" AutoPostBack="True" DataTextField="trsno" DataValueField="trsno" OnSelectedIndexChanged="DropDownList4_SelectedIndexChanged">
                        <asp:ListItem>請選擇--</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="auto-style4">
                    &nbsp;</td>

            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:CHACC_LITConnectionString %>" 
            SelectCommand="SELECT DISTINCT [years] FROM [TBTRS] ORDER BY [years] DESC">
        </asp:SqlDataSource>
        <br />
        <br />        
        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>        
        <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" AutoGenerateColumns="False" OnPageIndexChanging="GridView1_PageIndexChanging" >
            <AlternatingRowStyle BackColor="#F7F7F7" />
            <Columns>
                <asp:BoundField DataField="lead_pno" HeaderText="借出人" />
                <asp:BoundField DataField="lead_date" DataFormatString="{0:yyyy-MM-dd}" HeaderText="借出日" />
                <asp:BoundField DataField="return_date" DataFormatString="{0:yyyy-MM-dd}" HeaderText="歸還日" />
                <asp:BoundField DataField="remarks" HeaderText="備註" />
                <asp:TemplateField HeaderText="借出人">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("login_pno") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("login_pno") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="login_date" DataFormatString="{0:yyyy-MM-dd}" HeaderText="登記日" />
            </Columns>
            <EmptyDataTemplate>
                無歷史紀錄。
            </EmptyDataTemplate>
            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
            <PagerStyle ForeColor="#4A3C8C" HorizontalAlign="Right" BackColor="#E7E7FF" />
            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
            <SortedAscendingCellStyle BackColor="#F4F4FD" />
            <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
            <SortedDescendingCellStyle BackColor="#D8D8F0" />
            <SortedDescendingHeaderStyle BackColor="#3E3277" />
        </asp:GridView>
        <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
        <br /> 
        <asp:GridView ID="GridView2" runat="server" BackColor="#FFCC66" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" OnPageIndexChanging="GridView2_PageIndexChanging" OnRowCancelingEdit="GridView2_RowCancelingEdit" OnRowDeleting="GridView2_RowDeleting" OnRowEditing="GridView2_RowEditing" OnRowUpdating="GridView2_RowUpdating" DataKeyNames="id" OnSelectedIndexChanged="DropDownList4_SelectedIndexChanged" AutoGenerateColumns="False" EnableModelValidation="False">
            <Columns>
                <asp:CommandField ShowEditButton="True" />
                <asp:CommandField ShowDeleteButton="True" />
                <asp:TemplateField HeaderText="借出人工號">
                    <EditItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("lead_pno") %>'></asp:Label>
                        <asp:DropDownList ID="DropDownList6" runat="server" Width="138px" AutoPostBack="True" Height="17px" CssClass="auto-style5" OnSelectedIndexChanged="DropDownList6_SelectedIndexChanged">
                            <asp:ListItem>請選擇</asp:ListItem>
                        </asp:DropDownList>
                        <asp:DropDownList ID="DropDownList5" runat="server" Height="16px" Width="84px" DataSourceID="SqlDataSource2" DataTextField="DEPNAME" DataValueField="DEPNO" AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="DropDownList5_SelectedIndexChanged">
                            <asp:ListItem Value="0">請選擇--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SCHOOL_LITConnectionString %>" SelectCommand="SELECT DISTINCT [DEPNAME], [DEPNO] FROM [v_linya_peo_test] ORDER BY [DEPNO]"></asp:SqlDataSource>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("lead_pno") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="借閱日期" SortExpression="lead_date">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("lead_date", "{0:yyyy-MM-dd}") %>' TextMode="Date" HtmlEncode="False" convertemptystringtonull="true"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("lead_date", "{0:yyyy-MM-dd}") %>' TextMode="Date" HtmlEncode="False" ></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="歸還日期">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("return_date", "{0:yyyy-MM-dd}") %>' TextMode="Date" HtmlEncode="False"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("return_date", "{0:yyyy-MM-dd}") %>'  HtmlEncode="False" OnPreRender="Label2_PreRender"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="備註">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("return_date", "{0:yyyy-MM-dd}") %>' HtmlEncode="False" TextMode="Date"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("remarks") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                <br />
                 
                <table class="auto-style5">
                    <tr>
                        <td class="auto-style10">借閱人工號</td>
                        <td>
                            <asp:TextBox ID="TextBox4" runat="server" BorderStyle="None" ReadOnly="True"></asp:TextBox>
                            <asp:DropDownList ID="DropDownList7" runat="server" AutoPostBack="True" OnDataBinding="DropDownList7_DataBinding" OnSelectedIndexChanged="DropDownList7_SelectedIndexChanged1">
                                <asp:ListItem Value="0">請選擇-</asp:ListItem>
                            </asp:DropDownList>
                            <asp:DropDownList ID="DropDownList8" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3" DataTextField="DEPNAME" DataValueField="DEPNO" OnSelectedIndexChanged="DropDownList8_SelectedIndexChanged1">
                                <asp:ListItem Value="0">請選擇-</asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:SCHOOL_LITConnectionString %>" SelectCommand="SELECT DISTINCT [DEPNO], [DEPNAME] FROM [v_linya_peo_test] ORDER BY [DEPNO]"></asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style10">借閱日期</td>
                        <td>
                            <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("lead_date", "{0:yyyy-MM-dd}") %>' TextMode="Date"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style6">備註</td>
                        <td class="auto-style6">
                            <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
                            <asp:SqlDataSource ID="SqlDataSource4" runat="server" InsertCommand="INSERT INTO Lead_trsno1(lead_pno, trsno, lead_date, remarks) VALUES (@lead_pno, @trsno, @lead_date, @remarks);SELECT IDENT_CURRENT ('lead_trsno1') AS id" OnInserted="SqlDataSource4_Inserted">
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="TextBox4" Name="lead_pno" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="DropDownList3" Name="trsno" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="TextBox5" Name="lead_date" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="TextBox6" Name="remarks" PropertyName="Text" />
                                    <asp:Parameter DbType="Int32" Direction="Output" Name="id" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style10">
                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" style="height: 27px" Text="新增" />
                        </td>
                        <td>
                            <asp:Button ID="Button2" runat="server" Text="取消" Visible="False" />
                        </td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            <PagerStyle ForeColor="#000066" HorizontalAlign="Left" BackColor="White" />
            <RowStyle ForeColor="#000066" />
            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#007DBB" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#00547E" />
        </asp:GridView>
        <asp:Panel ID="Panel1" runat="server">
            <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="125px">
            </asp:DetailsView>
        </asp:Panel>
    </form>
</body>
</html>
