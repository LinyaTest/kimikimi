using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
//using System.Data.OleDb;
using System.Web.Configuration;
using System.Data.SqlClient;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

            
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        /*與Access連線 Begin
        string dbpath = "D:\\summons_DB.accdb";
        string Source;  //宣告連線字串
                        //Source = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + dbpath;
        Source = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + dbpath;
        OleDbConnection conn;               //宣告連線物件
        conn = new OleDbConnection(Source); //連線
        conn.Open();    //開啟資料庫
        Response.Write("<H2>ASP.NET 連線Access測試</H2>");
        Response.Write("<HR>");
        Response.Write("<H3> 成功連結到Access的伺服器</H3>");
        conn.Close();   //關閉資料庫
        與Access連線 End*/
        //與MS SQL 連線 BEGIN
        string Source,sqlstr;                                          //宣告連線字串
        int i;
        Source = "server=203.71.80.102;";          //伺服器
        Source += "database=SCHOOL_LIT;";   //資料庫
        Source += "user id=alltop;";                    // 帳號
        Source += "password=alltop123;";        //密碼
        SqlConnection conn;                             //宣告連線物件

       // SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["NorthwindConnectionString"].ConnectionString);
        conn = new SqlConnection(Source);

        conn.Open();
        sqlstr = "select * from v_empl_LIT ";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader reader= cmd.ExecuteReader();

        Response.Write("<tr>");
        for (i = 0; i <= reader.FieldCount - 1; i++)
            Response.Write("<td align=center>" + reader.GetName(i) + "</td>");
        Response.Write("</tr>");
        while(reader.Read())
        {
            Response.Write("<tr align=center");
            for (i = 0; i <= reader.FieldCount - 1; i++)
                Response.Write("<td>" + reader.GetValue(i) + "</td>");
            Response.Write("</tr>");
        }
        Response.Write("</table>");
        //Response.Write("<td>" + dr.GetName+ "</td>");
        //Response.Write("</tr>");

        Response.Write("<H2>ASP.NET 連線MS SQL測試</H2>");
        Response.Write("<HR>");
        Response.Write("<H3> 成功連結到MS SQL的伺服器</H3>");
        conn.Close();   //關閉資料庫
        //與MS SQL 連線 END
    }



    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void SqlDataSource3_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }

    protected void Button1_Click2(object sender, EventArgs e)
    {

    }
}