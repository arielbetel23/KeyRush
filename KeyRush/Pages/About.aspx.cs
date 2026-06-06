using System;

public partial class KeyRush_Pages_About : System.Web.UI.Page
{
    protected bool IsLoggedIn = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        string username = Session["username"] as string;
        IsLoggedIn = !string.IsNullOrEmpty(username) && username != "Guest";
    }
}
