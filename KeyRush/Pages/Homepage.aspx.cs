using System;

public partial class Pages_Default : System.Web.UI.Page
{
    // Exposed to the .aspx so the markup can decide what to render.
    protected bool IsLoggedIn = false;
    protected string BestWPM = "0";
    protected string BestCPS = "0";

    protected void Page_Load(object sender, EventArgs e)
    {
        // The homepage is public: guests are NOT redirected. A fresh session
        // defaults username to "Guest" (see Global.asax), so anything else
        // means a real logged-in user.
        string username = Session["username"] as string;
        IsLoggedIn = !string.IsNullOrEmpty(username) && username != "Guest";

        if (IsLoggedIn)
        {
            // Pull this user's personal bests for the stats section.
            object wpm = Helper.GetScalar("SELECT best_WPM FROM " + Helper.tblName + " WHERE username = '" + username + "'");
            object cps = Helper.GetScalar("SELECT best_CPS FROM " + Helper.tblName + " WHERE username = '" + username + "'");

            BestWPM = (wpm == null || wpm == DBNull.Value) ? "0" : Convert.ToDouble(wpm).ToString();
            BestCPS = (cps == null || cps == DBNull.Value) ? "0" : Convert.ToDouble(cps).ToString();
        }
    }
}
