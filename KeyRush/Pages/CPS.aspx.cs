using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class KeyRush_Pages_CPS : System.Web.UI.Page
{


    protected void Page_Load(object sender, EventArgs e)
    {
        if ((string)Session["username"] == "Guest")
        {
            Response.Redirect("About.aspx");
        }

        // Handle the client-side score submission (AJAX) before any HTML is rendered.
        if (Request.QueryString["ajax"] == "submitScore")
        {
            SubmitScore();
            return;
        }

        ShowLeaderboard();
        ShowMyRank();
    }

    public void SubmitScore()
    // Receives the CPS result from the client, updates the record if it is a new
    // personal best, and writes back "true"/"false" so the page can congratulate.
    {
        string username = (string)Session["username"];
        double cps = Convert.ToDouble(Request.QueryString["cps"]);

        object current = Helper.GetScalar("SELECT best_CPS FROM " + Helper.tblName + " WHERE username = '" + username + "'");
        double best = (current == null || current == DBNull.Value) ? 0 : Convert.ToDouble(current);
        bool broken = cps > best;

        Helper.UpdateBestScores(username, cps, 0);

        Response.Clear();
        Response.Write(broken ? "true" : "false");
        Response.End();
    }

    public void ShowLeaderboard()
    // Query the top 10 users by best_CPS and build the leaderboard table.
    {
        string sql = "SELECT TOP 10 username, best_CPS FROM " + Helper.tblName + " ORDER BY best_CPS DESC";
        DataSet ds = Helper.RetrieveTable(sql);
        DataTable users = ds.Tables[Helper.tblName];    // ds.Tables[0]
        string table = Helper.BuildLeaderboard(users, "best_CPS", "Best CPS", (string)Session["username"]);
        leaderboard.InnerHtml = table;
    }

    public int GetUserRank(string username)
    // The rank of the user = how many users have a higher best_CPS, plus one.
    {
        string sql = "SELECT COUNT(*) FROM " + Helper.tblName +
                " WHERE best_CPS > (SELECT best_CPS FROM " + Helper.tblName + " WHERE username = '" + username + "')";
        int higher = Convert.ToInt32(Helper.GetScalar(sql));
        return higher + 1;
    }

    public void ShowMyRank()
    // Show the current user's rank and score, even if they are not in the top 10.
    {
        string username = (string)Session["username"];
        int rank = GetUserRank(username);
        object score = Helper.GetScalar("SELECT best_CPS FROM " + Helper.tblName + " WHERE username = '" + username + "'");
        double best = (score == null || score == DBNull.Value) ? 0 : Convert.ToDouble(score);
        myRank.InnerHtml = "Your rank: <b>#" + rank + "</b> &nbsp;|&nbsp; Best CPS: <b>" + best + "</b>";
    }
}
