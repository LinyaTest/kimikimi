using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//----自己寫的（宣告)----
using System.Web.Configuration;
using System.Data;
using System.Data.SqlClient;
//----自己寫的（宣告)----

public partial class Default3 : System.Web.UI.Page
{
    //==== 這一段程式很常被用到，所以獨立寫成一個 DBInit副程式。
    //==== 這樣會讓程式的可讀性提高！
    protected void DBInit()   //====自己手寫的程式碼， DataAdapter / DataSet ====(Start)
    {
        SqlConnection Conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["CHACC_LITConnectionString"].ConnectionString);

        //== 第一，連結資料庫。
        Conn.Open();   //---- 這時候才連結DB

        SqlDataReader dr = null;
        string SqlStr;
        SqlStr = "select * from lead_trsno1 where lead_pno= '"+ DropDownList4.SelectedValue + "' and return_date is not null;select * from lead_trsno1 where trsno = '" + DropDownList4.SelectedValue + "' and return_date is null";
        /*
        SqlStr = "select CHACC_LIT.dbo.lead_trsno1.lead_pno,b.CNAME,a.lead_date,a.return_date,a.remarks,a.login_pno,a.login_date from CHACC_LIT.dbo.lead_trsno1, SCHOOL_LIT.dbo.EMPPEO" +
            "where a.lead_pno=b.PNO and" +
            "a.trsno = '" + DropDownList4.SelectedValue + "' and a.return_date is not null;" +
            "select * from lead_trsno1 where trsno = '" + DropDownList4.SelectedValue + "' and return_date is null";
        */
        SqlCommand cmd = new SqlCommand(SqlStr, Conn);

        try
        {
            //== 第二，執行SQL指令。
            dr = cmd.ExecuteReader();   //---- 這時候執行SQL指令，取出資料
                                        // do
                                        //{
                                        //==第三，自由發揮，把執行後的結果呈現到畫面上。
            if (dr.HasRows)
            {
                Label1.Text = "歷史借閱紀錄";
                GridView1.DataSource = dr;
                GridView1.DataBind();    //--資料繫結
            }
            else
            {
                //Label1.Text = "無歷史借閱紀錄";
                GridView1.DataSource = "";
                GridView1.DataBind();    //--資料繫結
            }

            //} while (dr.NextResult());

            dr.NextResult();
            if (dr.HasRows)
            {
                Label2.Text = "當前借閱紀錄";
                GridView2.DataSource = dr;
                GridView2.DataBind();    //--資料繫結
            }
            else
            {
                Label2.Text = "無當前借閱紀錄";
                GridView2.DataSource = "";
                GridView2.DataBind();    //--資料繫結
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
            //Session["RowIndex"] = 0;//為了人名下拉選單

            if (DropDownList2.SelectedValue == "0")
            {
                Response.Write("請選擇年度");
            }
            else if (DropDownList4.SelectedValue == "0")
            {
                Response.Write("請選擇傳票");
            }
            else
            {
                DBInit();   //---只有[第一次]執行本程式，才會進入 if判別式內部。
            }
        }
    }

    protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownList4.Items.Count > 1)
        {
            DropDownList4.Items.Clear();  //-- 清除所有的 子選項

            DropDownList4.Items.Add("請選擇--");  //-- 手動設定一個子選項
            DropDownList4.Items[0].Value = "0";
        }


        //----上面已經事先寫好NameSpace --  using System.Web.Configuration;  (連結資料庫)----
        SqlConnection Conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["CHACC_LITConnectionString"].ConnectionString);
        SqlDataReader dr = null;
        SqlCommand cmd = new SqlCommand("select trsno FROM TBTRS where years = '" + DropDownList2.SelectedValue + "' and substring(right(trsno,7),1,2)='" + DropDownList3.SelectedValue + "'", Conn);
        try
        {
            //== 第一，連結資料庫。
            Conn.Open();   //---- 這時候才連結DB
            //== 第二，執行SQL指令。
            dr = cmd.ExecuteReader();   //---- 這時候執行SQL指令，取出資料
            //==第三，自由發揮，把執行後的結果呈現到畫面上。
            DropDownList4.DataSource = dr;   //-- DropDownList的基本設定，Text與 Value已經在HTML畫面裡設定完成。
            DropDownList4.DataBind();

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
        if (DropDownList3.Items.Count > 1)
        {
            DropDownList3.Items.Clear();  //-- 清除「區域」所有的 子選項

            DropDownList3.Items.Add("請選擇--");  //-- 手動設定一個子選項
            DropDownList3.Items[0].Value = "0";
            //----------------------------------------------------
            DropDownList4.Items.Clear();  //-- 清除「道路」所有的 子選項

            DropDownList4.Items.Add("請選擇--");  //-- 手動設定一個子選項
            DropDownList4.Items[0].Value = "0";
        }

        //----上面已經事先寫好NameSpace --  using System.Web.Configuration;  (連結資料庫)----
        SqlConnection Conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["CHACC_LITConnectionString"].ConnectionString);
        SqlDataReader dr = null;
        SqlCommand cmd = new SqlCommand("select distinct substring(right(trsno,7),1,2) a FROM TBTRS where years = '" + DropDownList2.SelectedValue + "' order by a", Conn);
        try
        {
            //== 第一，連結資料庫。
            Conn.Open();   //---- 這時候才連結DB
            //== 第二，執行SQL指令。
            dr = cmd.ExecuteReader();   //---- 這時候執行SQL指令，取出資料
            //==第三，自由發揮，把執行後的結果呈現到畫面上。
            DropDownList3.DataSource = dr;   //-- DropDownList的基本設定，Text與 Value已經在HTML畫面裡設定完成。
            DropDownList3.DataBind();

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

    protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView2.EditIndex = e.NewPageIndex;

        DBInit();
    }

    protected void GridView2_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        Response.Write("GridView2_RowCancelingEdit");
        GridView2.EditIndex = -1;
        DBInit();
    }

    protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        SqlConnection Conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["CHACC_LITConnectionString"].ConnectionString);
        SqlDataAdapter myAdapter = new SqlDataAdapter();
        myAdapter.DeleteCommand = new SqlCommand("delete from [lead_trsno1] where [id]=@id", Conn);

        DataSet ds = new DataSet();
        myAdapter.SelectCommand = new SqlCommand("select * from lead_trsno1 where trsno='" + DropDownList4.SelectedValue + "'", Conn);
        myAdapter.Fill(ds, "lead_trsno1");
        //直接修改dataset 的內容
        ds.Tables["lead_trsno1"].Rows[e.RowIndex].Delete();
        myAdapter.DeleteCommand.Parameters.Add("@id", SqlDbType.Int, 4);
        myAdapter.DeleteCommand.Parameters["@id"].Value = (int)GridView2.DataKeys[e.RowIndex].Value;
        myAdapter.Update(ds, "lead_trsno1");
        DBInit();

    }

    protected void GridView2_RowEditing(object sender, GridViewEditEventArgs e)
    {
        Session["RowIndex"] = e.NewEditIndex;
        GridView2.EditIndex = e.NewEditIndex;
        GridView2.DataBind();
        DBInit();
        //
        /*
         if (DropDownList6.Items.Count > 1)
         {
             DropDownList3.Items.Clear();  //-- 清除「區域」所有的 子選項

             DropDownList3.Items.Add("請選擇--");  //-- 手動設定一個子選項
             DropDownList3.Items[0].Value = "0";
             //----------------------------------------------------
             DropDownList4.Items.Clear();  //-- 清除「道路」所有的 子選項

             DropDownList4.Items.Add("請選擇--");  //-- 手動設定一個子選項
             DropDownList4.Items[0].Value = "0";
         }*/
        /*
       //----上面已經事先寫好NameSpace --  using System.Web.Configuration;  (連結資料庫)----
       SqlConnection Conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["CHACC_LITConnectionString"].ConnectionString);
       SqlDataReader dr = null;
       SqlCommand cmd = new SqlCommand("select distinct substring(right(trsno,7),1,2) a FROM TBTRS where years = '" + DropDownList2.SelectedValue + "' order by a", Conn);
       try
       {
           //== 第一，連結資料庫。
           Conn.Open();   //---- 這時候才連結DB
           //== 第二，執行SQL指令。
           dr = cmd.ExecuteReader();   //---- 這時候執行SQL指令，取出資料
           //==第三，自由發揮，把執行後的結果呈現到畫面上。
           DropDownList3.DataSource = dr;   //-- DropDownList的基本設定，Text與 Value已經在HTML畫面裡設定完成。
           DropDownList3.DataBind();

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
       */
        //DBInit();

    }

    protected void GridView2_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int my_id = Convert.ToInt32(GridView2.DataKeys[e.RowIndex].Value);   //====主索引鍵====
        int rowIndex = Convert.ToInt32(Session["RowIndex"]);
        //mylead_pno = (TextBox)GridView2.Rows[e.RowIndex].Cells[4].Controls[0];
        GridView gv2 = (GridView)sender;
        //int my_id = Convert.ToInt32(GridView2.DataKeys[e.RowIndex].Value);   //====主索引鍵====
        Label mylead_pno = (Label)gv2.Rows[rowIndex].FindControl("Label6");
        //TextBox mylead_date = (TextBox)GridView2.Rows[e.RowIndex].FindControl("TextBox1") as TextBox;
        TextBox mylead_date = (TextBox)gv2.Rows[rowIndex].FindControl("TextBox1");
        //TextBox myreturn_date = (TextBox)GridView2.Rows[e.RowIndex].FindControl("TextBox2") as TextBox;
        TextBox myreturn_date = (TextBox)gv2.Rows[rowIndex].FindControl("TextBox2");
        //TextBox myremarks = (TextBox)GridView2.Rows[e.RowIndex].Cells[7].Controls[0];
        TextBox myremarks = (TextBox)gv2.Rows[rowIndex].FindControl("TextBox3");

        //TemplateField TF = (TemplateField)GridView2.Columns[2];

        
        SqlDataSource SqlDataSource1 = new SqlDataSource();
        //== 連結資料庫的連接字串 ConnectionString  ==
        SqlDataSource1.ConnectionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["CHACC_LITConnectionString"].ConnectionString;

        //SqlDataSource1.UpdateParameters.Clear();
        //== 設定SQL指令將會用到的參數 ==
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

        if (myreturn_date.Text == "")
        {
            SqlDataSource1.UpdateParameters.Add("return_date", DbType.DateTime, null);
        }
        else
        {
            DateTime strDate1 = DateTime.Parse(myreturn_date.Text);
            SqlDataSource1.UpdateParameters.Add("return_date", String.Format("{0:yyyy-MM-dd}", strDate1));
        }


        //== 日期格式需要轉換。String.Format()

        SqlDataSource1.UpdateParameters.Add("remarks", myremarks.Text.ToString());
        SqlDataSource1.UpdateParameters.Add("id", my_id.ToString());

        //下面的寫法也可以！
        //  SqlDataSource1.UpdateParameters.Add(new Parameter("id",TypeCode.Int32));
        //  SqlDataSource1.UpdateParameters["id"].DefaultValue = my_id.ToString();

        SqlDataSource1.UpdateCommand = "update[lead_trsno1] set[lead_pno] = @lead_pno, [lead_date] = @lead_date, [return_date] = @return_date, [remarks] = @remarks where [id] = @id";
        SqlDataSource1.Update();  //執行SQL指令--Update陳述句

        SqlDataSource1.Dispose();
        //==== 更新完成後，離開編輯模式 ====
        GridView2.EditIndex = -1;
        DBInit();
        

        /*
                SqlConnection Conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["CHACC_LITConnectionString"].ConnectionString);
                SqlDataAdapter myAdapter = new SqlDataAdapter();
                //----------------------事先寫好 UpdateCommand / DeleteCommand / InsertCommand
                myAdapter.UpdateCommand = new SqlCommand("update [lead_trsno1] set [lead_pno] = @lead_pno, " +
                    "[lead_date] = @lead_date, [return_date] = @return_date, [remarks] = @remarks where [id] = @id", Conn);

                DataSet ds = new DataSet();
                myAdapter.SelectCommand = new SqlCommand("select * from lead_trsno1 where trsno = '" + DropDownList4.SelectedValue + "' and return_date is null", Conn);

                myAdapter.Fill(ds, "lead_trsno1");
        */
        /*
        if (mylead_date.Text =="")
        {
            ds.Tables["lead_trsno1"].Rows[e.RowIndex]["lead_date"] = "1900/1/1";
        }
        else
        {
            ds.Tables["lead_trsno1"].Rows[e.RowIndex]["lead_date"] = mylead_date.Text;
        }
        if (myreturn_date.Text == "")
        {
            ds.Tables["lead_trsno1"].Rows[e.RowIndex]["return_date"] = "1900/1/1";
        }
        else
        {
            ds.Tables["lead_trsno1"].Rows[e.RowIndex]["return_date"] = myreturn_date.Text;
        }

        //---- 直接修改 DataSet的內容 --------------------------------
        ds.Tables["lead_trsno1"].Rows[e.RowIndex]["lead_pno"] = mylead_pno.Text;
        ds.Tables["lead_trsno1"].Rows[e.RowIndex]["remarks"] = myremarks.Text;
        */
        //==== 上面的SQL指令，有四個參數（前面有＠符號標示）。寫在下面：
        //----下面 [日期格式] 需要修正！
        /*
        myAdapter.UpdateCommand.Parameters.Add("@lead_pno", SqlDbType.Char, 10);
        myAdapter.UpdateCommand.Parameters["@lead_pno"].Value = (mylead_pno.Text).Trim();

        myAdapter.UpdateCommand.Parameters.Add("@lead_date", SqlDbType.Datetime);
        myAdapter.UpdateCommand.Parameters["@lead_date"].Value = mylead_date.Text;

        myAdapter.UpdateCommand.Parameters.Add("@return_date", SqlDbType.Datetime);
        myAdapter.UpdateCommand.Parameters["@return_date"].Value = myreturn_date.Text;

        myAdapter.UpdateCommand.Parameters.Add("@remarks", SqlDbType.VarChar, 50);
        myAdapter.UpdateCommand.Parameters["@remarks"].Value = myremarks.Text;

        myAdapter.UpdateCommand.Parameters.Add("@id", SqlDbType.Int, 8);
        myAdapter.UpdateCommand.Parameters["@id"].Value = (int)GridView2.DataKeys[e.RowIndex].Value;

        //---- GridView1.DataKeys[e.RowIndex].Value 是指：「使用者點選的那一列」資料，所對應的資料表「主索引鍵（Primary Key）值」。

        myAdapter.Update(ds, "lead_trsno1");    //把改寫後的DataSet，回寫到實體的資料庫裡面！
        */
        //----修改、更新完成！！離開「編輯」模式  ----
        //GridView2.EditIndex = -1;
        //DBInit();

    }

    protected void DropDownList4_SelectedIndexChanged(object sender, EventArgs e)
    {
        DBInit();
    }

    private DataView GetDV(string sql)
    {
        //SqlConnection Conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["SCHOOL_LITConnectionString"].ConnectionString);

        string SqlConStr = WebConfigurationManager.ConnectionStrings["SCHOOL_LITConnectionString"].ConnectionString.ToString();
        SqlConnection sqlCon = new SqlConnection(SqlConStr);
        DataView dv;
        SqlDataAdapter sqlAdp = new SqlDataAdapter();
        SqlCommand cmd;
        DataSet ds = new DataSet();
        sqlCon.Open();
        cmd = new SqlCommand(sql, sqlCon);
        sqlAdp.SelectCommand = cmd;
        sqlAdp.Fill(ds);
        dv = new DataView(ds.Tables[0]);
        return dv;
        sqlCon.Close();
    }

    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Write("GridView2_SelectedIndexChanged");
        // C#語法不能直接寫.Parent ====================
        String str = ((Control)sender).Parent.ClientID;
        // 資料來源 http://saloster.wordpress.com/2012/06/15/namingcontainer-gridview-templatefield-control/

        Response.Write("新的寫法（找出位於GridView第幾列，從零算起。請看最後一個數字）--" + str);
        // 結果會是 -- GridView1_ctl欄位數_列數
        //=====================================
        /*
        int rowIndex = Convert.ToInt32(Session["RowIndex"]);

        TextBox TB = (TextBox)GridView2.Rows[rowIndex].Cells[3].Controls[0];
        Calendar CA = (Calendar)GridView2.Rows[rowIndex].FindControl("Calendar1");

        TB.Text = CA.SelectedDate.ToShortDateString();
        */
    }


    protected void Label2_PreRender(object sender, EventArgs e)
    {
        Label a = (Label)sender;
        if (a.Text == "")
        {
            a.Text = "";
        }
    }

    protected void DropDownList5_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList dp5 = (DropDownList)sender;

        //----上面已經事先寫好NameSpace --  using System.Web.Configuration;  (連結資料庫)----
        SqlConnection Conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["SCHOOL_LITConnectionString"].ConnectionString);
        SqlDataReader dr1 = null;
        SqlCommand cmd = new SqlCommand("select PNO,CNAME FROM v_linya_peo_test where DEPNO = '" + dp5.SelectedValue + "' order by PNO", Conn);
        try
        {
            //== 第一，連結資料庫。
            Conn.Open();   //---- 這時候才連結DB
            //== 第二，執行SQL指令。
            dr1 = cmd.ExecuteReader();   //---- 這時候執行SQL指令，取出資料
                                        //==第三，自由發揮，把執行後的結果呈現到畫面上。
            DropDownList dp6 = (DropDownList)dp5.FindControl("DropDownList6");
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

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Session["RowIndex"] = GridView1.SelectedIndex;
    }

    protected void DropDownList6_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList dp6 = (DropDownList)sender;
        Label lbl6 = (Label)dp6.FindControl("Label6");
        lbl6.Text = dp6.SelectedValue.ToString();
    }


    protected void DropDownList8_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList dp8 = (DropDownList)sender;

        //----上面已經事先寫好NameSpace --  using System.Web.Configuration;  (連結資料庫)----
        SqlConnection Conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["SCHOOL_LITConnectionString"].ConnectionString);
        SqlDataReader dr1 = null;
        SqlCommand cmd = new SqlCommand("select PNO,CNAME FROM v_linya_peo_test where DEPNO = '" + dp8.SelectedValue + "' order by PNO", Conn);
        try
        {
            //== 第一，連結資料庫。
            Conn.Open();   //---- 這時候才連結DB
            //== 第二，執行SQL指令。
            dr1 = cmd.ExecuteReader();   //---- 這時候執行SQL指令，取出資料
                                         //==第三，自由發揮，把執行後的結果呈現到畫面上。
            DropDownList dp6 = (DropDownList)dp8.FindControl("DropDownList6");
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

    protected void DropDownList7_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList dp7 = (DropDownList)sender;

        //----上面已經事先寫好NameSpace --  using System.Web.Configuration;  (連結資料庫)----
        SqlConnection Conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["SCHOOL_LITConnectionString"].ConnectionString);
        SqlDataReader dr1 = null;
        SqlCommand cmd = new SqlCommand("select PNO,CNAME FROM v_linya_peo_test where DEPNO = '" + dp7.SelectedValue + "' order by PNO", Conn);
        try
        {
            //== 第一，連結資料庫。
            Conn.Open();   //---- 這時候才連結DB
            //== 第二，執行SQL指令。
            dr1 = cmd.ExecuteReader();   //---- 這時候執行SQL指令，取出資料
                                         //==第三，自由發揮，把執行後的結果呈現到畫面上。
            DropDownList dp8 = (DropDownList)dp7.FindControl("DropDownList8");
            dp8.DataValueField = "PNO";      //在此輸入的是 test資料表的欄位名稱
            dp8.DataTextField = "CNAME";   //在此輸入的是 test資料表的欄位名稱

            dp8.DataSource = dr1;   //-- DropDownList的基本設定，Text與 Value已經在HTML畫面裡設定完成。
            dp8.DataBind();

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


    protected void SqlDataSource3_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        GridView1.DataSource = "SqlDataSource1";
        //==== 更新完成後，離開編輯模式 ====
        GridView2.EditIndex = -1;
        DBInit();
    }

    protected void DropDownList8_SelectedIndexChanged1(object sender, EventArgs e)
    {
        DropDownList dp8 = (DropDownList)sender;

        //----上面已經事先寫好NameSpace --  using System.Web.Configuration;  (連結資料庫)----
        SqlConnection Conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["SCHOOL_LITConnectionString"].ConnectionString);
        SqlDataReader dr1 = null;
        SqlCommand cmd = new SqlCommand("SELECT '' AS PNO , '' AS CNAME union select PNO,CNAME AS Text FROM v_linya_peo_test where DEPNO = '" + dp8.SelectedValue + "' order by PNO", Conn);
        try
        {
            //== 第一，連結資料庫。
            Conn.Open();   //---- 這時候才連結DB
            //== 第二，執行SQL指令。
            dr1 = cmd.ExecuteReader();   //---- 這時候執行SQL指令，取出資料
                                         //==第三，自由發揮，把執行後的結果呈現到畫面上。
            DropDownList dp7 = (DropDownList)dp8.FindControl("DropDownList7");
            dp7.DataValueField = "PNO";      //在此輸入的是 test資料表的欄位名稱
            dp7.DataTextField = "CNAME";   //在此輸入的是 test資料表的欄位名稱

            dp7.DataSource = dr1;   //-- DropDownList的基本設定，Text與 Value已經在HTML畫面裡設定完成。
            dp7.DataBind();
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

    protected void DropDownList7_SelectedIndexChanged1(object sender, EventArgs e)
    {
        DropDownList dp7 = (DropDownList)sender;
        TextBox tb4 = (TextBox)dp7.FindControl("TextBox4");
        tb4.Text = dp7.SelectedValue;
    }

    protected void DropDownList7_DataBinding(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Write("good");
        //Button bt1 = (Button)sender;
        //SqlDataSource sq4 = (SqlDataSource)bt1.FindControl("SqlDataSource4");
        //sq4.Insert();
    }

    protected void SqlDataSource4_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        /*
        SqlDataSource sq4 = (SqlDataSource)sender;

        //== 2.  新增一筆 Oders訂單主檔，成功之後先抓住 Primary Key，以待後續使用。
        Session["myID"] = e.Command.Parameters["@id"].Value.ToString();
       
        //******************************************************(start)
        //== 3.  把剛剛新增完成的 Oders訂單內容，透過 DetailsView呈現出來（唯讀畫面）
        SqlConnection Conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["CHACC_LITConnectionString"].ConnectionString.ToString());
        Conn.Open();

        //SqlCommand cmd = new SqlCommand("SELECT * FROM [Orders] Where OrderID = " + Session["myOrdersID"].ToString(), Conn);
        //為了避免資料隱碼（SQL Injection）攻擊，可寫成參數的作法
        SqlCommand cmd = new SqlCommand("SELECT * FROM [lead_trsno1] Where id = @myID", Conn);
        cmd.Parameters.AddWithValue("OID", Session["myID"].ToString());

        SqlDataReader dr = cmd.ExecuteReader();

        DetailsView1.DataSource = dr;
        DetailsView1.DataBind();

        Panel2.Visible = true;
        DetailsView1.DefaultMode = DetailsViewMode.ReadOnly;
        //-- 新增完成後，DetailsView就變成「唯讀」模式。只能顯示資料。

        cmd.Cancel();
        dr.Close();
        Conn.Close();
        //******************************************************(end)

        Panel3.Visible = true;
        //-- 新增完成後，開始輸入這筆訂單的「產品資訊與明細」。所以 DetailsView要出現在畫面上。
        Label4_OrderId.Text = Session["myOrdersID"].ToString();
        */
    }
    
}