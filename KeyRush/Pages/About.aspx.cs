using System;

public partial class KeyRush_Pages_About : System.Web.UI.Page
{
    // Exposed to the .aspx so the markup can decide what to render.
    protected bool IsLoggedIn = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        // Public page — no redirect for guests, no database access needed.
        // A fresh session defaults username to "Guest" (see Global.asax),
        // so anything else means a real logged-in user.
        string username = Session["username"] as string;
        IsLoggedIn = !string.IsNullOrEmpty(username) && username != "Guest";
    }
}
