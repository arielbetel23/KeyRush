using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Activities.Validation;

public partial class KeyRush_Pages_Signin2 : System.Web.UI.Page
{
    public void SignIn()
    {
        string username = Request.Form["txtUsername"];
        string password = Request.Form["txtPassword"];
        string sql = "SELECT * FROM users WHERE username = @username AND password = @password";
        if (Helper.GetScalar(sql,
                new SqlParameter("@username", username),
                new SqlParameter("@password", password)) != null)
        {
            User user = Helper.GetRow(username, password);
            Session["admin"] = user.GetAdmin();
            Session["username"] = user.GetUsername();
            Response.Redirect("Homepage.aspx");
        }
        else
            Response.Write("<center><h1>Login failed. Invalid username or password</h1></center>");
        
    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    

}