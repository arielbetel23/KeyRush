using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Activities.Validation;
using System.Activities.Expressions;
using System.Security.Cryptography;

public partial class pages_admin : System.Web.UI.Page
{
    public void ShowUsers()
    {
        string sql = BuildSQL("");
        DataSet ds = Helper.RetrieveTable(sql);
        DataTable users = ds.Tables[Helper.tblName];    // ds.Tables[0]
        string table = Helper.BuildUsersTable(users);
        showUsersTable.InnerHtml = table;
    }
    public string BuildSQL(string username)
    {
        if (username == null || username.Length == 0)
            return "SELECT * FROM " + Helper.tblName;
        else
            return String.Format("SELECT * FROM " + Helper.tblName + " WHERE username LIKE \'%{0}%\'", username);
    }
    public string BuildSQL(string column, string sort)
    {
        return String.Format("SELECT * FROM " + Helper.tblName + " ORDER BY {0} {1}", column, sort);
    }
    public void ClickSearch(object sender, EventArgs e)
    {
        string username = Request.Form["searchName"];
        string sql = BuildSQL(username);
        DataSet ds = Helper.RetrieveTable(sql);
        DataTable users = ds.Tables["users"];    // ds.Tables[0]
        string table = Helper.BuildUsersTable(users);
        showUsersTable.InnerHtml = table;
    }
    public void ClickSort(object sender, EventArgs e)
    {
        string columnName = columns.Value;
        string sort = ASC.Checked ? ASC.Value : DESC.Value;
        if (columnName.Equals("empty"))
            showUsersTable.InnerHtml = "Need to pick up a column to order by";
        else
        {
            string sql = BuildSQL(columnName, sort);
            DataSet ds = Helper.RetrieveTable(sql);
            DataTable users = ds.Tables["users"];    // ds.Tables[0]
            string table = Helper.BuildUsersTable(users);
            showUsersTable.InnerHtml = table;
        }
    }
    public void DeleteUsers(object sender, EventArgs e)
    {
        int count = 0;
        for (int i = 0; i < Request.Form.Count; i++)
        {
            if (Request.Form.AllKeys[i].Contains("chk"))
                count++;
        }
        string[] usersToDelete = new string[count];
        int index = 0;
        for (int i = 0; i < Request.Form.Count; i++)
        {
            if (Request.Form.AllKeys[i].Contains("chk"))
            {
                usersToDelete[index] = Request.Form.AllKeys[i].Remove(0, 3);
                index++;
            }
        }

        Helper.Delete(usersToDelete);
        
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((bool)Session["admin"] == false && (string)Session["username"] != "Guest")
            Response.Redirect("Notalowedadmin.aspx");
        if ((bool)Session["admin"] == false && (string)Session["username"] == "Guest")
            Response.Redirect("About.aspx");
        ShowUsers();
    }
}