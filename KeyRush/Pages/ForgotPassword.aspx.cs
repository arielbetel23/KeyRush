using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Activities.Validation;

public partial class KeyRush_Pages_ForgotPassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public static bool Checkuser(string username, int q1, string ans1, int q2, string ans2)
    {
        string sql = "SELECT * FROM users WHERE username = '" + username + "' AND question1 = '" + q1 + "' AND firstanswer = '" + ans1 + "' AND question2 = '" + q2 + "' AND secondanswer = '" + ans2 + "'";


        if (Helper.GetScalar(sql) != null)
            return true;
        return false;
    }

    public void Update(string username, string password, int q1, string ans1, int q2, string ans2)
    {
        if (Checkuser(username, q1, ans1, q2, ans2))
        {

            string sql = "UPDATE users SET password = '" + password + "'WHERE username = '" + username + "'AND question1 = '" + q1 + "'AND firstanswer = '" + ans1 + "'AND question2 = '" + q2 + "'AND secondanswer = '" + ans2 + "'";


            int n = Helper.ExecuteNonQuery(sql);
            
            if (n > 0)
            {
               Response.Write("password update");
            }

            Response.AddHeader("REFRESH", "3;URL=About.aspx");
        }

        else
        {
            Response.Write("invalid field!");

        }
    }
}