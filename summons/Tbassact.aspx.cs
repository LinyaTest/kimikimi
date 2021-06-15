using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//----自己寫的（宣告)----
using System.Web.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
//----自己寫的（宣告)----

public partial class Tbassact : System.Web.UI.Page
{
    protected void DBInit()   //====自己手寫的程式碼， DataAdapter / DataSet ====(Start)
    {
        SqlConnection Conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["dbAGS_LITConnectionString"].ConnectionString);

        //== 第一，連結資料庫。
        Conn.Open();   //---- 這時候才連結DB

        SqlDataReader dr = null;
        string SqlStr;
        //SqlStr = "select * from lead_trsno4 where trsno= '" + DropDownList3.SelectedValue + "' and return_date is not null;" +
        //    "select * from lead_trsno4 where trsno = '" + DropDownList3.SelectedValue + "' and lead_date is not null and return_date is null";
        SqlStr = "SELECT a.id,a.lead_pno,b.CNAME,b.DEPNAME,a.ass_code_CHL" +
            ",a.lead_date,a.return_date,a.remarks,a.login_pno,a.login_date " +
            "FROM [dbAGS_LIT].[dbo].[Lead_assact] a,[SCHOOL_LIT].[dbo].[v_linya_peo_test] b " +
            "where a.lead_pno=b.PNO and a.ass_code_CHL= @ass_code_CHL and a.return_date is not null;" +
            "SELECT a.id,a.lead_pno,b.CNAME,b.DEPNAME,a.ass_code_CHL" +
            ",a.lead_date,a.return_date,a.remarks,a.login_pno,a.login_date " +
            "FROM [dbAGS_LIT].[dbo].[Lead_assact] a,[SCHOOL_LIT].[dbo].[v_linya_peo_test] b " +
            "where a.lead_pno=b.PNO and a.ass_code_CHL = @ass_code_CHL and a.lead_date is not null and a.return_date is null";
    
        SqlCommand cmd = new SqlCommand(SqlStr, Conn);
        cmd.Parameters.AddWithValue("@ass_code_CHL", DropDownList2.SelectedValue.ToString());
        Response.Write(DropDownList2.SelectedValue.ToString());

        try
        {
            //== 第二，執行SQL指令。
            dr = cmd.ExecuteReader();   //---- 這時候執行SQL指令，取出資料
                                        // do
                                        //{
                                        //==第三，自由發揮，把執行後的結果呈現到畫面上。
            if (dr.HasRows)
            {
                Label6.Text = "歷史紀錄";
                GridView1.DataSource = dr;
                GridView1.DataBind();    //--資料繫結
                ViewState["HasRows1"] = "1";
            }
            else
            {
                Label6.Text = "無歷史紀錄";
                GridView1.DataSource = "";
                GridView1.DataBind();    //--資料繫結
                ViewState["HasRows1"] = "0";
            }

            //} while (dr.NextResult());

            dr.NextResult();
            if (dr.HasRows)
            {
                Label2.Text = "借出中紀錄";
                GridView2.DataSource = dr;
                GridView2.DataBind();    //--資料繫結
                ViewState["HasRows2"] = "1";
            }
            else
            {
                Label2.Text = "傳票無借出";
                GridView2.DataSource = "";
                GridView2.DataBind();    //--資料繫結
                ViewState["HasRows2"] = "0";
            }
            if((ViewState["HasRows1"].ToString() =="1") && (ViewState["HasRows2"].ToString() == "1"))
            {
                GridView1.Visible = true;
                GridView1.Visible = true;
                Panel1.Visible = false;
            }
            else if((ViewState["HasRows1"].ToString() == "1") && (ViewState["HasRows2"].ToString() == "0"))
            {
                GridView1.Visible = false;
                GridView1.Visible = true;
                TextBox6.Text = DropDownList2.SelectedValue.ToString();
            }
            else if((ViewState["HasRows1"].ToString() == "0") && (ViewState["HasRows2"].ToString() == "1"))
            {
                GridView1.Visible = false;
                GridView1.Visible = true;
                Panel1.Visible = false;
                Label4.Text = "傳票借出中";
            }
            else
            {
                GridView1.Visible = false;
                GridView1.Visible = false;
                TextBox6.Text = DropDownList2.SelectedValue.ToString();
            }
        }
        catch (Exception ex)
        {   //---- 如果程式有錯誤或是例外狀況，將執行這一段
            //---- http://www.dotblogs.com.tw/billchung/archive/2009/03/31/7779.aspx
            Response.Write("<b>Error Message----  </b>" + ex.ToString() + "<HR />");
        }
        finally
        {
            // == 第四，釋放資源、關閉資料庫的連結。
            //---- Always call Close when done reading.
            if (dr != null)
            {
                cmd.Cancel();
                //----關閉DataReader之前，一定要先「取消」SqlCommand
                //參考資料： http://blog.darkthread.net/blogs/darkthreadtw/archive/2007/04/23/737.aspx
                dr.Close();
            }

            //---- Close the connection when done with it.
            if (Conn.State == ConnectionState.Open)
            {
                Conn.Close();
                Conn.Dispose(); //---- 一開始宣告有用到 new的,最後必須以 .Dispose()結束
            }
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string a = "", b ="";
            ViewState["HasRows1"] = a;
            ViewState["HasRows2"] = b;
            Session["RowIndex"] = 0;//為了人名下拉選單
            Session["dep_no"] = "079";

            if (DropDownList1.SelectedValue == "0")
            {
                //Response.Write("請選擇年度");
            }
            else
            {
                DBInit();   //---只有[第一次]執行本程式，才會進入 if判別式內部。
            }
        }
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownList2.Items.Count > 1)
        {
            DropDownList2.Items.Clear();  //-- 清除「區域」所有的 子選項

            DropDownList2.Items.Add("請選擇--");  //-- 手動設定一個子選項
            DropDownList2.Items[0].Value = "0";
            //----------------------------------------------------
            DropDownList2.Items.Clear();  //-- 清除「道路」所有的 子選項

            DropDownList2.Items.Add("請選擇--");  //-- 手動設定一個子選項
            DropDownList2.Items[0].Value = "0";
        }
        DropDownList dp = (DropDownList)sender;
        SqlDataSource sq = (SqlDataSource)dp.FindControl("SqlDataSource1");

        //----上面已經事先寫好NameSpace --  using System.Web.Configuration;  (連結資料庫)----
        SqlConnection Conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["dbAGS_LITConnectionString"].ConnectionString);
        SqlDataReader dr = null;
        //SqlCommand cmd = new SqlCommand("SELECT [acc_year], [goods_name], [dep_no], [dep_name], [use_dep_no], [ass_code_CHL], [ass_group] FROM [vTBASSACT_Group] WHERE(([use_dep_no] = @use_dep_no) AND([acc_year] = @acc_year))", Conn);
        string str = "SELECT ass_code_CHL+goods_name as a,ass_code_CHL,goods_name FROM [vTBASSACT] WHERE [use_dep_no] = '" + Session["dep_no"].ToString() + "' and [acc_year] = '" + DropDownList1.SelectedValue + "'";
        SqlCommand cmd = new SqlCommand("SELECT ass_code_CHL+goods_name as a,ass_code_CHL,goods_name FROM [vTBASSACT] WHERE [use_dep_no] = '" + Session["dep_no"].ToString() + "' and [acc_year] = '"+ DropDownList1.SelectedValue + "'", Conn);
        cmd.Parameters.AddWithValue("@use_dep_no", "079");
        
        try
        {
            //== 第一，連結資料庫。
            Conn.Open();   //---- 這時候才連結DB
            //== 第二，執行SQL指令。
            dr = cmd.ExecuteReader();   //---- 這時候執行SQL指令，取出資料

            DropDownList2.DataValueField = "ass_code_CHL";      //在此輸入的是 test資料表的欄位名稱
            DropDownList2.DataTextField = "a";   //在此輸入的是 test資料表的欄位名稱

            //==第三，自由發揮，把執行後的結果呈現到畫面上。
            DropDownList2.DataSource = dr;   //-- DropDownList的基本設定，Text與 Value已經在HTML畫面裡設定完成。
            DropDownList2.DataBind();
            
        }
        catch (Exception ex)
        {   //---- 如果程式有錯誤或是例外狀況，將執行這一段
            Response.Write("<b>Error Message----  </b>" + ex.ToString() + "<hr />");
        }
        finally
        {   // == 第四，釋放資源、關閉資料庫的連結。
            if (dr != null)
            {
                cmd.Cancel();
                dr.Close();
            }
            if (Conn.State == ConnectionState.Open)
            {
                Conn.Close();
                Conn.Dispose(); //---- 一開始宣告有用到 New的,最後必須以 .Dispose()結束
            }
        }
    }

    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        DBInit();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (TextBox5.Text == "")
        {
            Response.Write("請輸入人員資料");
            return;
        }
        else if (TextBox7.Text == "")
        {
            Response.Write("請輸入借閱日期");
            return;
        }
        
        //== 資料新增 ==
        SqlDataSource SqlDataSource2 = new SqlDataSource();

        //== 連結資料庫的連接字串 ConnectionString  ==
        SqlDataSource2.ConnectionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["dbAGS_LITConnectionString"].ConnectionString;

        Response.Write(TextBox5.ToString() + "<br/>");
        Response.Write(TextBox6.ToString() + "<br/>");
        Response.Write(TextBox7.ToString() + "<br/>");
        Response.Write(TextBox8.ToString() + "<br/>");
        //== 撰寫SQL指令(Insert Into) ==
        
        SqlDataSource2.InsertCommand = "Insert into lead_assact(lead_pno,ass_code_CHL,lead_date,remarks) values('" + TextBox5.Text + "','"+ TextBox6.Text + "','" + TextBox7.Text + "','"+ TextBox8.Text+ "')";

        //== 執行SQL指令 / 新增 .Insert() ==
        int aff_row = SqlDataSource2.Insert();
        
        if (aff_row == 0)
            Response.Write("<span style= 'color:red; font-size:20pt'>資料新增失敗！/<span>");
        else
            Response.Write("<span style= 'color:red; font-size:20pt'>資料新增成功！<span>");

        SqlDataSource2.Dispose();

        Button bt = (Button)sender;
        Panel pl = (Panel)bt.FindControl("Panel1");
        pl.Visible = false;
        DBInit();    //== GridView的資料重整

    }

    protected void GridView2_RowEditing(object sender, GridViewEditEventArgs e)
    {
        Session["RowIndex"] = e.NewEditIndex;
        GridView2.EditIndex = e.NewEditIndex;
        GridView2.DataBind();
        DBInit();
    }

    protected void GridView2_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int my_id = Convert.ToInt32(GridView2.DataKeys[e.RowIndex].Value);   //====主索引鍵====
        int rowIndex = Convert.ToInt32(Session["RowIndex"]);
        string tmp;

        GridView gv2 = (GridView)sender;
        TextBox mylead_pno = (TextBox)gv2.Rows[rowIndex].FindControl("gv2tb_lead_pno");
        TextBox mylead_date = (TextBox)gv2.Rows[rowIndex].FindControl("gv2tb_lead_date");
        TextBox myreturn_date = (TextBox)gv2.Rows[rowIndex].FindControl("gv2tb_return_date");
        TextBox myremarks = (TextBox)gv2.Rows[rowIndex].FindControl("gv2tb_remarks");

        SqlDataSource SqlDataSource1 = new SqlDataSource();
        //== 連結資料庫的連接字串 ConnectionString  ==
        SqlDataSource1.ConnectionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["dbAGS_LITConnectionString"].ConnectionString;

        SqlDataSource1.UpdateParameters.Clear();
        //== 設定SQL指令將會用到的參數 ==
        tmp = mylead_pno.Text;
        mylead_pno.Text = tmp.Trim();
        SqlDataSource1.UpdateParameters.Add("lead_pno", mylead_pno.Text.ToString());

        if (mylead_date.Text == "")
        {
            SqlDataSource1.UpdateParameters.Add("lead_date", DbType.DateTime, null);
        }
        else
        {
            DateTime strDate = DateTime.Parse(mylead_date.Text);
            SqlDataSource1.UpdateParameters.Add("lead_date", String.Format("{0:yyyy-MM-dd}", strDate));
        }

        //== 日期格式需要轉換。String.Format()

        SqlDataSource1.UpdateParameters.Add("remarks", myremarks.Text.ToString());
        SqlDataSource1.UpdateParameters.Add("id", my_id.ToString());

        //下面的寫法也可以！
        //  SqlDataSource1.UpdateParameters.Add(new Parameter("id",TypeCode.Int32));
        //  SqlDataSource1.UpdateParameters["id"].DefaultValue = my_id.ToString();
        if (myreturn_date.Text == "")
        {
            SqlDataSource1.UpdateParameters.Add("return_date", String.Format("{0:yyyy-MM-dd}", DBNull.Value));
        }
        else
        {
            DateTime strDate1 = DateTime.Parse(myreturn_date.Text);
            SqlDataSource1.UpdateParameters.Add("return_date", String.Format("{0:yyyy-MM-dd}", strDate1));
        }

        SqlDataSource1.UpdateCommand = "update[lead_assact] set[lead_pno] = @lead_pno, [lead_date] = @lead_date, [return_date] = @return_date, [remarks] = @remarks where [id] = @id";
        SqlDataSource1.Update();  //執行SQL指令--Update陳述句

        SqlDataSource1.Dispose();
        //==== 更新完成後，離開編輯模式 ====
        GridView2.EditIndex = -1;
        DBInit();

    }
    protected void DropDownList5_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList dp = (DropDownList)sender;

        //----上面已經事先寫好NameSpace --  using System.Web.Configuration;  (連結資料庫)----
        SqlConnection Conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["SCHOOL_LITConnectionString"].ConnectionString);
        SqlDataReader dr1 = null;
        SqlCommand cmd = new SqlCommand("select '' as PNO,' ' as CNAME union select PNO as PNO,CNAME as CNAME FROM v_linya_peo_test where DEPNO = '" + dp.SelectedValue + "' order by PNO", Conn);
        try
        {
            //== 第一，連結資料庫。
            Conn.Open();   //---- 這時候才連結DB
            //== 第二，執行SQL指令。
            dr1 = cmd.ExecuteReader();   //---- 這時候執行SQL指令，取出資料
                                         //==第三，自由發揮，把執行後的結果呈現到畫面上。
            DropDownList dp4 = (DropDownList)dp.FindControl("DropDownList4");
            dp4.DataValueField = "PNO";      //在此輸入的是 test資料表的欄位名稱
            dp4.DataTextField = "CNAME";   //在此輸入的是 test資料表的欄位名稱

            dp4.DataSource = dr1;   //-- DropDownList的基本設定，Text與 Value已經在HTML畫面裡設定完成。
            dp4.DataBind();

        }
        catch (Exception ex)
        {   //---- 如果程式有錯誤或是例外狀況，將執行這一段
            Response.Write("<b>Error Message----  </b>" + ex.ToString() + "<hr />");
        }
        finally
        {   // == 第四，釋放資源、關閉資料庫的連結。
            if (dr1 != null)
            {
                cmd.Cancel();
                dr1.Close();
            }
            if (Conn.State == ConnectionState.Open)
            {
                Conn.Close();
                Conn.Dispose(); //---- 一開始宣告有用到 New的,最後必須以 .Dispose()結束
            }
        }

    }

    protected void DropDownList4_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList dp4 = (DropDownList)sender;
        TextBox tb4=(TextBox)dp4.FindControl("gv2tb_lead_pno");
        tb4.Text = dp4.SelectedValue.ToString();
    }

    protected void DropDownList7_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList dp = (DropDownList)sender;

        //----上面已經事先寫好NameSpace --  using System.Web.Configuration;  (連結資料庫)----
        SqlConnection Conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["SCHOOL_LITConnectionString"].ConnectionString);
        SqlDataReader dr1 = null;
        SqlCommand cmd = new SqlCommand("select '' as PNO,' ' as CNAME union select PNO as PNO,CNAME as CNAME FROM v_linya_peo_test where DEPNO = '" + dp.SelectedValue + "' order by PNO", Conn);
        try
        {
            //== 第一，連結資料庫。
            Conn.Open();   //---- 這時候才連結DB
            //== 第二，執行SQL指令。
            dr1 = cmd.ExecuteReader();   //---- 這時候執行SQL指令，取出資料
                                         //==第三，自由發揮，把執行後的結果呈現到畫面上。
            DropDownList dp6 = (DropDownList)dp.FindControl("DropDownList6");
            dp6.DataValueField = "PNO";      //在此輸入的是 test資料表的欄位名稱
            dp6.DataTextField = "CNAME";   //在此輸入的是 test資料表的欄位名稱

            dp6.DataSource = dr1;   //-- DropDownList的基本設定，Text與 Value已經在HTML畫面裡設定完成。
            dp6.DataBind();

        }
        catch (Exception ex)
        {   //---- 如果程式有錯誤或是例外狀況，將執行這一段
            Response.Write("<b>Error Message----  </b>" + ex.ToString() + "<hr />");
        }
        finally
        {   // == 第四，釋放資源、關閉資料庫的連結。
            if (dr1 != null)
            {
                cmd.Cancel();
                dr1.Close();
            }
            if (Conn.State == ConnectionState.Open)
            {
                Conn.Close();
                Conn.Dispose(); //---- 一開始宣告有用到 New的,最後必須以 .Dispose()結束
            }
        }

    }

    protected void DropDownList6_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList dp = (DropDownList)sender;
        TextBox tb5 = (TextBox)dp.FindControl("TextBox5");
        tb5.Text = dp.SelectedValue.ToString();
        tb5.Visible = true;

    }

    protected void GridView2_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView2.EditIndex = -1;
        DBInit();
    }

    protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int rowIndex = Convert.ToInt32(Session["RowIndex"]);
        Label lb17 = (Label)GridView2.Rows[rowIndex].FindControl("Label7");//trsno 
        GridView gv2 = (GridView)sender;
        HiddenField hf1 = (HiddenField)gv2.NamingContainer.FindControl("HiddenField1");

        if (lb17.Text.ToString().Trim() == hf1.Value.ToString())
        {
            Response.Write("輸入正確" + lb17.Text.ToString().Trim() + "@@@" + hf1.Value.ToString());
        }
        else
        {
            Response.Write("輸入不同" + lb17.Text.ToString().Trim() + "@@@" + hf1.Value.ToString());
            return;
        }
        //((Button)e.Row.Cells[11].Controls[0]).Attributes.Add("onclick", string.Format("javascript:return confirm('您是要刪除" + e.Row.Cells[2].Text + " 麼')"));

        SqlConnection Conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["dbAGS_LITConnectionString"].ConnectionString);
        Conn.Open();   //---- 這時候才連結DB
        //== (2). 執行SQL指令。
        SqlCommand cmd = new SqlCommand("delete from [lead_assact] where [id] = @id", Conn);
        cmd.Parameters.AddWithValue("@id", (int)GridView2.DataKeys[e.RowIndex].Value);
        //---- GridView1.DataKeys[e.RowIndex].Value 是指：「使用者點選的那一列」資料，所對應的資料表「主索引鍵（Primary Key）值」。
        //== (3). 自由發揮。
        int RecordsAffected = cmd.ExecuteNonQuery();
        Response.Write("執行 Delete的SQL指令以後，影響了" + RecordsAffected + "列的紀錄。");
        //-- 或者是，您可以這樣寫，代表有更動到一些紀錄。
        //if (RecordsAffected > 0)  {
        //    Response.Write("資料更動成功。共有" + RecordsAffected + "列紀錄被影響。");
        // }

        //== (4). 釋放資源、關閉資料庫的連結。
        cmd.Cancel();
        if (Conn.State == ConnectionState.Open)
        {
            Conn.Close();
            Conn.Dispose(); //---- 一開始宣告有用到 New的,最後必須以 .Dispose()結束
        }
        //==========================================================

        //----「刪除」已經完成！！記得重新整理畫面，重新載入資料----
        Panel1.Visible = false;
        DBInit();
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        TextBox5.Text = "";
        TextBox5.Visible = false;
        TextBox7.Text = "";
        TextBox8.Text = "";
        DropDownList6.SelectedIndex = 0;
        DropDownList7.SelectedIndex = 0;
        Panel1.Visible = false;
        DBInit();
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        Button bt = (Button)sender;
        Panel1.Visible = true;
        bt.Visible = false;
    }

    protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
    {
        Calendar1.Visible = true;
    }

    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {
        //TextBox7.Text = Calendar1.SelectedDate.ToShortDateString();
        this.TextBox7.Text = this.Calendar1.SelectedDate.ToString("yyyy-MM-dd");
        Calendar1.Visible = false;
    }

    protected void ImageButton3_Click(object sender, ImageClickEventArgs e)
    {
        //int rowIndex = Convert.ToInt32(Session["RowIndex"]);
        //ImageButton ib = (ImageButton)sender;
        //GridView gv2 = (GridView)this.GridView2;
        //Calendar ca2 = (Calendar)gv2.Rows[rowIndex].Cells[3].FindControl("Calender2");
        //Calendar ca2 = (Calendar)gv2.SelectedRow.Cells[2].FindControl("Calender2");
        //ca2.Visible = true;
    }

    protected void Calendar2_SelectionChanged(object sender, EventArgs e)
    {
        Calendar ca2 = (Calendar)sender;
        TextBox tb = (TextBox)ca2.FindControl("gv2tb_lead_date");
        tb.Text = ca2.SelectedDate.ToShortDateString();
        ca2.Visible = false;
    }


    protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int rowIndex = Convert.ToInt32(Session["RowIndex"]);
        switch (e.CommandName)
        {
            case "img":
                //int index = Convert.ToInt32(e.CommandArgument.ToString());
                int index= Convert.ToInt32(e.CommandArgument.ToString());
                Response.Write(e.CommandArgument.ToString());
                Calendar ca2 = (Calendar)GridView2.Rows[rowIndex].FindControl("Calendar2");
                if (ca2.Visible == true)
                {
                    ca2.Visible = false;
                }
                else
                {
                    ca2.Visible = true;
                }
                break;
            case "img2":
                Calendar ca3 = (Calendar)GridView2.Rows[rowIndex].FindControl("Calendar3");
                if (ca3.Visible == true)
                {
                    ca3.Visible = false;
                }
                else
                {
                    ca3.Visible = true;
                }
                break;
            case "Delete":
                /*
                Label lb17 = (Label)GridView2.Rows[rowIndex].FindControl("Label7");//trsno 
                GridView gv2 = (GridView)sender;
                HiddenField hf1 = (HiddenField)gv2.NamingContainer.FindControl("HiddenField1");
                if(lb17.Text.ToString() == hf1.Value.ToString())
                {
                    Response.Write("輸入正確"+ lb17.Text.ToString() + " "+ hf1.Value.ToString());
                }
                else
                {
                    Response.Write("輸入不同" + lb17.Text.ToString() + " " + hf1.Value.ToString());
                }
                */
                break;
        }
    }


    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //((Button)e.Row.Cells[11].Controls[0]).Attributes.Add("onclick", string.Format("javascript:return confirm('您是要刪除" + e.Row.Cells[2].Text + " 麼')"));
                //LinkButton lb2 = (LinkButton)e.Row.Cells[0].FindControl("LinkButton2");
                //註解：先抓住第一格裡面的第一個控制項，是一個按鈕（Button）控制項。
                //          然後，在這個按鈕控制項上面，添加 JavaScript（如下）。

                //正確執行 ---- 
            //    lb2.OnClientClick = "javascript:return confirm('再一次確認，您確定要對 id編號-- " + e.Row.Cells[1].Text + " 的資料，進行處置動作嗎？')";
            //lb2.Attributes.Add("onclick", "javascript:if (confirm('再一次確認，您確定要刪除嗎？')){return true;} else {return false;}");    

        }
    }

    protected void Calendar3_SelectionChanged(object sender, EventArgs e)
    {
        Calendar ca3 = (Calendar)sender;
        TextBox tb = (TextBox)ca3.FindControl("gv2tb_return_date");
        tb.Text = ca3.SelectedDate.ToShortDateString();
        ca3.Visible = false;
    }
}