using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class KeyRush_Pages_EditUser : System.Web.UI.Page
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    public bool Authentication(string username, string password)
    {
        string sql = string.Format("SELECT admin FROM users WHERE username='{0}' AND password='{1}'", username, password);
        object scalar = Helper.GetScalar(sql);
        if (scalar != null)
            return true;
        return false;
    }

    public void Edit(string[] columns, string[] arr)
    {
        string sql = "UPDATE " + Helper.tblName + " SET ";
        for (int i = 1; i < arr.Length; i++)
        {
            if (!arr[i].Equals(""))
                sql += columns[i] + "=\'" + arr[i] + "\',";
        }
        sql = sql.Substring(0, sql.Length - 1) + " WHERE username=\'" + arr[0] + "\'";
        int n = Helper.ExecuteNonQuery(sql);
        if (n > 0)
            Response.Write("User has been updated succesfully");
    }

}