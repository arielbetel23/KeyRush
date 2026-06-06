using System;

public partial class Pages_Default : System.Web.UI.Page
{
    protected bool IsLoggedIn = false;
    protected string BestWPM = "0";
    protected string BestCPS = "0";

    protected void Page_Load(object sender, EventArgs e)
    {
        string username = Session["username"] as string;
        IsLoggedIn = !string.IsNullOrEmpty(username) && username != "Guest";

        if (IsLoggedIn)
        {
            object wpm = Helper.GetScalar("SELECT best_WPM FROM " + Helper.tblName + " WHERE username = '" + username + "'");
            object cps = Helper.GetScalar("SELECT best_CPS FROM " + Helper.tblName + " WHERE username = '" + username + "'");

            BestWPM = (wpm == null || wpm == DBNull.Value) ? "0" : Convert.ToDouble(wpm).ToString();
            BestCPS = (cps == null || cps == DBNull.Value) ? "0" : Convert.ToDouble(cps).ToString();
        }
    }
}
