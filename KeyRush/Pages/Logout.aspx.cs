using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class KeyRush_Pages_Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        Session.Clear();
        Session.Abandon();
        Session["username"] = "Guest";
        
        Response.Redirect("About.aspx");
    }
}