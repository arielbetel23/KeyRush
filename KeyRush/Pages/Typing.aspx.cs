using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class KeyRush_Pages_Typing : System.Web.UI.Page
{
    static string[] words = {
        "the","of","and","to","in","is","you","that","it","he","was","for","on","are","as","with","his","they","at",
        "be","this","have","from","or","one","had","by","word","but","not","what","all","were","we","when","your","can",
        "said","there","use","an","each","which","she","do","how","their","if","will","up","other","about","out","many","then",
        "them","these","so","some","her","would","make","like","him","into","time","has","look","two","more","write","go","see",
        "number","no","way","could","people","my","than","first","water","been","call","who","oil","its","now","find","long","down",
        "day","did","get","come","made","may","part","over","new","sound","take","only","little","work","know","place","year","live",
        "me","back","give","most","very","after","thing","our","just","name","good","sentence","man","think","say","great","where","help",
        "through","much","before","line","right","too","mean","old","any","same","tell","boy","follow","came","want","show","also","around",
        "form","three","small","set","put","end","does","another","well","large","must","big","even","such","because","turn","here","why",
        "ask","went","men","read","need","land","different","home","us","move","try","kind","hand","picture","again","change","off","play",
        "spell","air","away","animal","house","point","page","letter","mother","answer","found","study","still","learn","should","world","high","every",
        "near","add","food","between","own","below","country","plant","last","school","father","keep","tree","never","start","city","earth","eye",
        "light","thought","head","under","story","saw","left","few","while","along","might","close","something","seem","next","hard","open","example"
    };

    protected void Page_Load(object sender, EventArgs e)
    {
        if ((string)Session["username"] == "Guest")
        {
            Response.Redirect("About.aspx");
        }

        if (Request.QueryString["ajax"] == "submitScore")
        {
            SubmitScore();
            return;
        }

        ShowLeaderboard();
        ShowMyRank();
    }

    public void SubmitScore()
    {
        string username = (string)Session["username"];
        double wpm = Convert.ToDouble(Request.QueryString["wpm"]);

        object current = Helper.GetScalar("SELECT best_WPM FROM " + Helper.tblName + " WHERE username = '" + username + "'");
        double best = (current == null || current == DBNull.Value) ? 0 : Convert.ToDouble(current);
        bool broken = wpm > best;

        Helper.UpdateBestScores(username, 0, wpm);

        Response.Clear();
        Response.Write(broken ? "true" : "false");
        Response.End();
    }

    public void ShowLeaderboard()
    {
        string sql = "SELECT TOP 10 username, best_WPM FROM " + Helper.tblName + " ORDER BY best_WPM DESC";
        DataSet ds = Helper.RetrieveTable(sql);
        DataTable users = ds.Tables[Helper.tblName];
        string table = Helper.BuildLeaderboard(users, "best_WPM", "Best WPM", (string)Session["username"]);
        leaderboard.InnerHtml = table;
    }

    public int GetUserRank(string username)
    {
        string sql = "SELECT COUNT(*) FROM " + Helper.tblName +
                " WHERE best_WPM > (SELECT best_WPM FROM " + Helper.tblName + " WHERE username = '" + username + "')";
        int higher = Convert.ToInt32(Helper.GetScalar(sql));
        return higher + 1;
    }

    public void ShowMyRank()
    {
        string username = (string)Session["username"];
        int rank = GetUserRank(username);
        object score = Helper.GetScalar("SELECT best_WPM FROM " + Helper.tblName + " WHERE username = '" + username + "'");
        double best = (score == null || score == DBNull.Value) ? 0 : Convert.ToDouble(score);
        myRank.InnerHtml = "Your rank: <b>#" + rank + "</b> &nbsp;|&nbsp; Best WPM: <b>" + best + "</b>";
    }

    public string GetWordsJs()
    {
        Random rnd = new Random();
        string[] shuffled = words.OrderBy(w => rnd.Next()).ToArray();

        StringBuilder sb = new StringBuilder();
        sb.Append("[");
        for (int i = 0; i < shuffled.Length; i++)
        {
            if (i > 0)
                sb.Append(",");
            sb.Append("\"" + shuffled[i] + "\"");
        }
        sb.Append("]");
        return sb.ToString();
    }
}
