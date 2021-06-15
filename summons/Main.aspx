<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Main.aspx.cs" Inherits="Main" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .Style_Select {
            width: 185px;
            height: 27px;
            font-size: large;
            font-weight: bold;
        }
        .Content {
            width: 100%;
            font-size: xx-large;
        }
        .auto-style15 {
            text-align: center;
            font-size: large;
            width: 100%;
        }
        .edit_style {
        font-size: large;
        width: 33%;
        height: 50%;
        text-align: left;
        background-color: #FFFFCC;
        font-weight: bold;
    }
        .column1 {
            width: 20%;
            height: 100%;
            font-size: x-large;
            background-color: #FFFFCC;
            font-weight: bold;
            text-align: right;
        }
    .column2 {
        width: 60%;
        height: 100%;
        font-size: x-large;
        background-color: #FFFFCC;
        font-weight: bold;
        text-align: left;
    }
        .column3 {
            width: 20%;
            height: 100%;
            font-size: large;
            background-color: #FFFFCC;
            font-weight: bold;
            text-align: left;
        }
        .auto-style23 {
            width: 20%;
            height: 100%;
            font-size: large;
            background-color: #FFFFCC;
            font-weight: bold;
            text-align: left;
        }
        .column22 {
            width: 80%;
            height: 100%;
            font-size: x-large;
            background-color: #FFFFCC;
            font-weight: bold;
            text-align: left;
        }
        .auto-style25 {
            width: 100%;
        }
        .auto-style26 {
            text-align: left;
        }
        .auto-style30 {
            width: 152px;
        }
        .auto-style32 {
            width: 97px;
            height: 27px;
            font-size: large;
            font-weight: bold;
        }
        .auto-style33 {
            width: 97px;
        }
        .auto-style36 {
        text-align: center;
    }
    .auto-style37 {
        height: 100%;
    }
    .auto-style38 {
        z-index: 1;
    }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <table class="Content">
        <tr>
            <td class="column1">年度：</td>
            <td class="column2">
                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="years" DataValueField="years" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AppendDataBoundItems="True" Font-Size="X-Large">
                    <asp:ListItem Value="0">請選擇年度</asp:ListItem>
                </asp:DropDownList>
                
            </td>
            <td class="column3">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CHACC_LITConnectionString %>" SelectCommand="select DISTINCT years from TBTRS ORDER BY years desc"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="column1">月份：</td>
            <td class="column2">
                <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataTextField="month" DataValueField="month" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" Font-Size="X-Large">
                    <asp:ListItem Value="0">請選擇月份</asp:ListItem>
                </asp:DropDownList>
                
            </td>
            <td class="column3">
                <asp:HiddenField ID="HiddenField1" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="column1">傳票號碼：</td>
            <td class="column2">
                <asp:DropDownList ID="DropDownList3" runat="server" AutoPostBack="True" DataTextField="a" DataValueField="trsno" AppendDataBoundItems="True" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged" Font-Size="X-Large" Width="543px">
                    <asp:ListItem Value="0">請選擇傳票號碼</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td  class="column3">
                &nbsp;</td>
        </tr>
        </table>
        <table>
        <tr>
            <td class="auto-style37"></td>
            <td class="column22">
                <asp:Label ID="Label6" runat="server" BackColor="#FFFF99" BorderColor="#FFFF99"></asp:Label>
            </td>
        </tr>
        
        <tr>
            <td>
            </td>
            <td>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="id">
            <Columns>
                <asp:TemplateField HeaderText="借出日">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("lead_date", "{0:yyyy-MM-dd}") %>' CssClass="auto-style17" Height="26px" Width="183px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("lead_date", "{0:yyyy-MM-dd}") %>' CssClass="Style_Select"></asp:Label>
                    </ItemTemplate>
                    <ControlStyle Font-Size="X-Large" />
                    <HeaderStyle Font-Size="X-Large" />
                    <ItemStyle Font-Size="X-Large" ForeColor="#3399FF" />
                </asp:TemplateField>
                <asp:BoundField HeaderText="調案事由" />
                <asp:BoundField HeaderText="調閱方式" />
                <asp:BoundField HeaderText="影印份數" />
                <asp:BoundField DataField="DEPNAME" HeaderText="申請單位" >
                <ControlStyle Font-Size="X-Large" />
                <HeaderStyle Font-Size="X-Large" />
                <ItemStyle Font-Size="X-Large" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="申請人" Visible="False">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" CssClass="Style_Select" Text='<%# Bind("lead_pno") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("lead_pno") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="CNAME" HeaderText="申請人姓名" >
                <ControlStyle Font-Size="X-Large" />
                <HeaderStyle Font-Size="X-Large" />
                <ItemStyle Font-Size="X-Large" />
                </asp:BoundField>
                <asp:BoundField HeaderText="分機" />
                <asp:TemplateField HeaderText="歸還日">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" CssClass="Style_Select" Height="25px" Text='<%# Bind("return_date", "{0:yyyy-MM-dd}") %>' Width="166px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" CssClass="Style_Select" Text='<%# Bind("return_date", "{0:yyyy-MM-dd}") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle Font-Size="X-Large" ForeColor="#FF0066" />
                    <HeaderStyle Font-Size="X-Large" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="備註">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" CssClass="Style_Select" Text='<%# Bind("remarks") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" CssClass="Style_Select" Text='<%# Bind("remarks") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle Font-Size="X-Large" />
                    <HeaderStyle Font-Size="X-Large" />
                </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                無歷史借閱紀錄。
            </EmptyDataTemplate>
        </asp:GridView>
            </td>
        </tr>
        <tr>
            <td></td>
            <td class="auto-style23">
                 <asp:Label ID="Label2" runat="server" BackColor="#FFFF99" BorderColor="#FFFF99" CssClass="column22"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
        <asp:GridView ID="GridView2" runat="server" CellPadding="2" ForeColor="Black" AutoGenerateColumns="False" CssClass="auto-style15" DataKeyNames="id" OnRowEditing="GridView2_RowEditing" OnRowUpdating="GridView2_RowUpdating" OnRowCancelingEdit="GridView2_RowCancelingEdit" OnRowDeleting="GridView2_RowDeleting" OnRowCommand="GridView2_RowCommand" OnRowDataBound="GridView2_RowDataBound" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" GridLines="None">
            <AlternatingRowStyle BackColor="PaleGoldenrod" />
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="更新"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="取消"></asp:LinkButton>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="編輯"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick="return GetUserValue();" Text="刪除"></asp:LinkButton>
                    </ItemTemplate>
                    <ControlStyle Font-Size="X-Large" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="傳票號碼" Visible="False">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("trsno") %>' Visible="False"></asp:TextBox>
                        <asp:Label ID="Label9" runat="server" Font-Bold="True" ForeColor="White" Text='<%# Bind("trsno") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("trsno") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="借出單位">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" BorderStyle="None" ForeColor="#663300" ReadOnly="True" Text='<%# Bind("DEPNAME") %>' CssClass="Style_Select" Visible="False"></asp:TextBox>
                        <asp:Label ID="Label8" runat="server" Font-Bold="True" ForeColor="White" Text='<%# Bind("DEPNAME") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("DEPNAME") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle Font-Size="X-Large" ForeColor="Black" />
                    <HeaderStyle Font-Size="X-Large" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="借出人姓名">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" ForeColor="#FF0066" ReadOnly="True" Text='<%# Bind("CNAME") %>' CssClass="edit_style" Visible="False"></asp:TextBox>
                        <asp:Label ID="Label10" runat="server" Font-Bold="True" ForeColor="White" Text='<%# Bind("CNAME") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("CNAME") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle Font-Size="X-Large" ForeColor="Black" />
                    <HeaderStyle Font-Size="X-Large" />
                    <ItemStyle ForeColor="Black" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="借出人" Visible="False">
                    <EditItemTemplate>
                        <asp:TextBox ID="gv2tb_lead_pno" runat="server" Text='<%# Bind("lead_pno") %>' ForeColor="Red" Width="110px" CssClass="edit_style" Height="24px" ReadOnly="True" Visible="False"></asp:TextBox>
                        <asp:Label ID="Label11" runat="server" Font-Bold="True" ForeColor="White" Text='<%# Bind("lead_pno") %>'></asp:Label>
                        <asp:DropDownList ID="DropDownList5" runat="server" AppendDataBoundItems="True" AutoPostBack="True" CssClass="edit_style" DataSourceID="SqlDataSource2" DataTextField="DEPNAME" DataValueField="DEPNO" OnSelectedIndexChanged="DropDownList5_SelectedIndexChanged" Visible="False">
                            <asp:ListItem Value="0">請選擇部門</asp:ListItem>
                        </asp:DropDownList>                        
                        <asp:DropDownList ID="DropDownList4" runat="server" AutoPostBack="True" CssClass="edit_style" OnSelectedIndexChanged="DropDownList4_SelectedIndexChanged" Visible="False">
                            <asp:ListItem Value="0">請選擇人員</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SCHOOL_LITConnectionString %>" SelectCommand="SELECT DISTINCT [DEPNO], [DEPNAME] FROM [v_linya_peo_test] ORDER BY [DEPNO]"></asp:SqlDataSource>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("lead_pno") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle Font-Size="X-Large" ForeColor="Black" />
                    <HeaderStyle Font-Size="X-Large" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="借出日">
                    <EditItemTemplate>
                        <asp:TextBox ID="gv2tb_lead_date" runat="server" Text='<%# Bind("lead_date", "{0:yyyy-MM-dd}") %>' CssClass="Style_Select" ReadOnly="True" Visible="False"></asp:TextBox>
                        <asp:ImageButton ID="ImageButton3" runat="server" Height="40px" ImageUrl="~/Calendar_Icon.png" Width="40px" CommandName="img" CssClass="edit_style" Visible="False"/>
                        <asp:Label ID="Label12" runat="server" Font-Bold="True" ForeColor="White" Text='<%# Bind("lead_date", "{0:yyyy-MM-dd}") %>'></asp:Label>
                        <asp:Calendar ID="Calendar2" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" OnSelectionChanged="Calendar2_SelectionChanged" Visible="False" Width="220px">
                            <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                            <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                            <OtherMonthDayStyle ForeColor="#999999" />
                            <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                            <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                            <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                            <WeekendDayStyle BackColor="#CCCCFF" />
                        </asp:Calendar>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("lead_date", "{0:yyyy-MM-dd}") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle Font-Size="X-Large" ForeColor="#3399FF" />
                    <HeaderStyle Font-Size="X-Large" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="歸還日">
                    <EditItemTemplate>
                        <asp:TextBox ID="gv2tb_return_date" runat="server" Text='<%# Bind("return_date", "{0:yyyy-MM-dd}") %>' CssClass="edit_style" ReadOnly="True"></asp:TextBox>
                        <asp:ImageButton ID="ImageButton4" runat="server" CommandName="img2" Height="40px" ImageUrl="~/Calendar_Icon.png" Width="40px" />
                        <asp:Calendar ID="Calendar3" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Visible="False" Width="220px" OnSelectionChanged="Calendar3_SelectionChanged">
                            <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                            <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                            <OtherMonthDayStyle ForeColor="#999999" />
                            <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                            <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                            <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                            <WeekendDayStyle BackColor="#CCCCFF" />
                        </asp:Calendar>   
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("return_date", "{0:yyyy-MM-dd}") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle Font-Size="X-Large" ForeColor="#FF3399" />
                    <HeaderStyle Font-Size="X-Large" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="備註">
                    <EditItemTemplate>
                        <asp:TextBox ID="gv2tb_remarks" runat="server" Text='<%# Bind("remarks") %>' CssClass="auto-style21" Height="41px" Width="280px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("remarks") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle Font-Size="X-Large" />
                    <HeaderStyle Font-Size="X-Large" />
                </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                傳票目前沒有借出，如要借出請新增借出紀錄~<br />
                <asp:Button ID="Button3" runat="server" Font-Size="Large" OnClick="Button3_Click" Text="新增借出資料" />
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
            </td>
        </tr>
        <tr>
            <td>

            </td>
            <td class="auto-style26">

                <asp:FormView ID="FormView1" runat="server" DefaultMode="Edit" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" DataKeyNames="id" GridLines="Horizontal" Height="153px" Width="540px" CssClass="auto-style38">
                    <EditItemTemplate>
                        <table class="auto-style25">
                            <tr>
                                <td class="auto-style33"><asp:Label ID="Label33" runat="server" Text="調案事由:" CssClass="Style_Select"></asp:Label></td>
                                <td class="auto-style30"> <asp:Label ID="Label41" runat="server" Text='<%# Bind("lead_reason") %>' CssClass="Style_Select"></asp:Label></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td class="auto-style33"><asp:Label ID="Label42" runat="server" Text="調閱方式：" CssClass="Style_Select"></asp:Label></td>
                                <td class="auto-style30"><asp:RadioButtonList ID="RadioButtonList1" runat="server" Width="186px" RepeatDirection="Horizontal" CssClass="auto-style35">
                                    <asp:ListItem Value="1">調閱</asp:ListItem>
                                    <asp:ListItem Value="2">影印，共</asp:ListItem>
                                    </asp:RadioButtonList></td>
                                <td><asp:TextBox ID="TextBox13" runat="server" Width="20px" CssClass="Style_Select"></asp:TextBox>
                                    <asp:Label ID="Label43" runat="server" CssClass="Style_Select" >份</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style33">
                                    <asp:Label ID="Label44" runat="server" Text="會計年度：" CssClass="Style_Select"></asp:Label>
                                </td>
                                <td class="auto-style30">
                                    <asp:Label ID="Label45" runat="server" Text="Label" CssClass="Style_Select"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style33">
                                    <asp:Label ID="Label46" runat="server" Text="傳票號碼：" CssClass="Style_Select"></asp:Label>
                                </td>
                                <td class="auto-style30">
                                    <asp:Label ID="Label47" runat="server" Text='<%# Bind("trsno") %>' CssClass="Style_Select"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style33">
                                    <asp:Label ID="Label48" runat="server" Text="傳票內容：" CssClass="Style_Select"></asp:Label>
                                </td>
                                <td class="auto-style30">
                                    <asp:Label ID="Label49" runat="server" Text="Label" CssClass="Style_Select"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style33"><asp:Label ID="Label34" runat="server" Text="借出單位:" CssClass="Style_Select"></asp:Label></td>
                                <td class="auto-style30"><asp:Label ID="Label40" runat="server" Text='<%# Bind("DEPNAME") %>' CssClass="Style_Select"></asp:Label></td>
                            </tr>
                            <tr>
                                <td class="auto-style32"><asp:Label ID="Label35" runat="server" Text="申請人:" CssClass="Style_Select"></asp:Label></td>
                                <td class="auto-style30"><asp:Label ID="Label39" runat="server" Text='<%# Bind("CNAME") %>' CssClass="Style_Select"></asp:Label></td>
                            </tr>
                            <tr>
                                <td class="auto-style33"></td>
                                <td class="auto-style30"></td>
                            </tr>
                            <tr>
                                <td class="auto-style33"><asp:Label ID="Label36" runat="server" Text="借出日期" CssClass="Style_Select"></asp:Label></td>
                                <td><asp:Label ID="Label37" runat="server" Text='<%# Bind("lead_date") %>' CssClass="Style_Select"></asp:Label></td>
                            </tr>
                            <tr>
                                <td><asp:Label ID="Label38" runat="server" Text="歸還日期" CssClass="Style_Select"></asp:Label></td>
                                <td>
                                    <asp:TextBox ID="TextBox12" runat="server" Text='<%# Bind("return_date") %>' CssClass="Style_Select"></asp:TextBox>
                                    <asp:ImageButton ID="ImageButton5" runat="server" Height="49px" ImageUrl="~/Calendar_Icon.png" />
                                    <asp:Calendar ID="Calendar4" runat="server"></asp:Calendar>
                                </td>
                            </tr>
                        </table>                     

                    </EditItemTemplate>
                    <EditRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                    <EmptyDataTemplate>
                        <div class="auto-style36">
                            傳票目前沒有借出，如要借出請新增借出紀錄~<br />
                            <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="新增借出資料" />
                        </div>
                    </EmptyDataTemplate>
                    <FooterStyle BackColor="White" ForeColor="#333333" />
                    <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                    <ItemTemplate>
                        <asp:Label ID="Label17" runat="server" CssClass="style1" Text="ID:   "></asp:Label>
                        <asp:Label ID="Label18" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                        <br />
                        <asp:Label ID="Label19" runat="server" Text="傳票號碼"></asp:Label>
                        <asp:Label ID="Label20" runat="server" Text='<%# Eval("trsno") %>'></asp:Label>
                        <br />
                        <asp:Label ID="Label27" runat="server" Text="調案事由"></asp:Label>
                        <asp:Label ID="Label28" runat="server" Text='<%# Bind("lead_reason") %>'></asp:Label>
                        <br />
                        <asp:Label ID="Label23" runat="server" Text="借出單位"></asp:Label>
                        <asp:Label ID="Label24" runat="server" Text="Label"></asp:Label>
                        <br />
                        <asp:Label ID="Label25" runat="server" Text="借出人姓名"></asp:Label>
                        <asp:Label ID="Label26" runat="server" Text='<%# Bind("CNAME") %>'></asp:Label>
                        <br />
                        <asp:Label ID="Label29" runat="server" Text="借出日期"></asp:Label>
                        <asp:Label ID="Label30" runat="server" Text='<%# Bind("Lead_date") %>'></asp:Label>
                        <br />
                        <asp:Label ID="Label31" runat="server" Text="歸還日期"></asp:Label>
                        <asp:Label ID="Label32" runat="server" Text='<%# Bind("return_date") %>'></asp:Label>
                    </ItemTemplate>
                    <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="White" ForeColor="#333333" />
                </asp:FormView>

            </td>
        </tr>    
    </table>
    <asp:Panel ID="Panel1" runat="server" Visible="False">
    <table>
        <tr>
            <td>
                <asp:Label ID="Label4" runat="server" CssClass="column1"></asp:Label>
            </td>
            <td>
                &nbsp;&nbsp;&nbsp;<asp:Label ID="Label15" runat="server" CssClass="Style_Select" Text="借閱人："></asp:Label>
&nbsp;<asp:TextBox ID="TextBox5" runat="server" CssClass="Style_Select" BorderStyle="None" ForeColor="Red" ReadOnly="True" Width="119px" Font-Size="Large" Visible="False"></asp:TextBox>
                <asp:DropDownList ID="DropDownList7" runat="server" CssClass="Style_Select" DataSourceID="SqlDataSource3" DataTextField="DEPNAME" DataValueField="DEPNO" AutoPostBack="True" OnSelectedIndexChanged="DropDownList7_SelectedIndexChanged" AppendDataBoundItems="True">
                    <asp:ListItem>請選擇部門</asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="DropDownList6" runat="server" CssClass="Style_Select" OnSelectedIndexChanged="DropDownList6_SelectedIndexChanged" AutoPostBack="True" AppendDataBoundItems="false">
                    <asp:ListItem>請選擇人員</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:Label ID="Label14" runat="server" CssClass="Style_Select" Text="借閱日期："></asp:Label>
                <asp:TextBox ID="TextBox7" runat="server" CssClass="Style_Select" Font-Size="Large" ReadOnly="True" TextMode="Date"></asp:TextBox>
                <asp:ImageButton ID="ImageButton2" runat="server" Height="67px" ImageUrl="~/Calendar_Icon.png" OnClick="ImageButton2_Click" Width="81px" />
                <asp:Calendar ID="Calendar1" runat="server" OnSelectionChanged="Calendar1_SelectionChanged" Visible="False" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
                    <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                    <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                    <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                    <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                    <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                    <WeekendDayStyle BackColor="#CCCCFF" />
                </asp:Calendar>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:Label ID="Label13" runat="server" CssClass="Style_Select" Text="備註："></asp:Label>
                &nbsp;<asp:TextBox ID="TextBox8" runat="server" CssClass="Style_Select"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:Label ID="Label7" runat="server" Text="傳票號碼：" Visible="False" CssClass="Style_Select"></asp:Label>
                <asp:TextBox ID="TextBox6" runat="server" CssClass="Style_Select" BorderStyle="None" ReadOnly="True" Visible="False"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>

            </td>
            <td>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:SCHOOL_LITConnectionString %>" SelectCommand="SELECT DISTINCT [DEPNO], [DEPNAME] FROM [v_linya_peo_test] ORDER BY [DEPNO]"></asp:SqlDataSource>
                <br />
                <asp:Button ID="Button1" runat="server" Text="新增資料" OnClick="Button1_Click" PostBackUrl="~/Main.aspx" Font-Size="X-Large"/>                
                <asp:Button ID="Button2" runat="server" Font-Size="X-Large" OnClick="Button2_Click" Text="取消新增" />
            </td>
        </tr>
    </table>
    <br />
    </asp:Panel>
</asp:Content>
