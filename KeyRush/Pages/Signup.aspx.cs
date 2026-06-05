using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Activities.Validation;

public partial class KeyRush_Pages_Signup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public static bool IsExist(string username)
    {
        string sql = "SELECT * FROM " + Helper.tblName + " WHERE username = '" + username + "'";
        return Helper.GetScalar(sql) != null;
    }
    public static bool isverfy(string verfypassword, string password)
    {
        bool check = true;
        if (verfypassword != password)
        {
            check = false;
        }
        return check;
    }







    public void Signup()
    {

        string username = Request.Form["txtUsername"];
        string password = Request.Form["txtPassword"];
        string verfypassword = Request.Form["txtVerifyPassword"];
        string email = Request.Form["email"];
        if (!IsExist(username))
        {




            
            string firstname = Request.Form["txtFirstname"];
            string lastname = Request.Form["txtLastname"];
            string[] birthday = Request.Form["birthdate"].Split('-');
            int day = Convert.ToInt32(birthday[0]);
            int month = Convert.ToInt32(birthday[1]);
            int year = Convert.ToInt32(birthday[2]);
            DateTime birth = new DateTime(day, month, year);

            string phonenumber = Convert.ToString(Request.Form["phonenumber"]);
            bool gender = Convert.ToBoolean(Request.Form["gender"]);
            int question1 = Convert.ToInt32(Request.Form["question1"]);
            string answer1 = Request.Form["answer1"];
            int question2 = Convert.ToInt32(Request.Form["question2"]);
            string answer2 = Request.Form["answer2"];
            bool admin = false;
            User user = new User(username, password, firstname, lastname, birth, gender, email, phonenumber, admin, question1, answer1, question2, answer2, 0, 0);
            Helper.Insert(user);
            Response.Write("<h1>Signed up successful. Moving to home page</h1>");
            Response.Redirect("Signin2.aspx");







        }
        else
        {
            Response.Write("<h1>Sign up failed! This username is already being used!</h1> ");
        }

    }
}