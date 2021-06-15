using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }


    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownList1.SelectedValue == "0")
        {
            DropDownList2.Items.Clear();   // 清空選項
            DropDownList2.DataSourceID = null;   //防呆，避免出錯！
            DropDownList3.Items.Clear();
            DropDownList3.DataSourceID = null;
            Label1.Text = "請勿挑選「請選擇--」！！此選項無作用！！";
        }
        else
        {
            DropDownList2.Items.Clear();
            DropDownList2.Items.Add("==請選擇月份==");
            Response.Write(DropDownList1.SelectedValue);
            DropDownList2.DataSourceID = "SqlDataSource2";

            DropDownList3.Items.Clear();
            DropDownList3.DataSourceID = null;
        }
    }

    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList3.Items.Clear();
        DropDownList3.Items.Add("==請選擇傳票==");
        DropDownList3.DataSourceID = "SqlDataSource3";
    }

    protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
    {
        Label1.Text = DropDownList1.SelectedItem.Text +"年"+ DropDownList2.SelectedItem.Text + "月 傳票號碼:"+DropDownList3.SelectedItem.Text;
        GridView1.DataSourceID = "SqlDataSource4";
        GridView2.DataSourceID = "SqlDataSource5";
    }
}