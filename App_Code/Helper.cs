using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public static class Helper 
{
    public const string DBName = "Database.mdf";   //Name of the MSSQL Database.
    public const string tblName = "users";      // Name of the user Table in the Database
    public const string conString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\"
                                    + DBName + ";Integrated Security=True";   // The Data Base is in the App_Data = |DataDirectory|

    //public static string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Database.mdf;Integrated Security=True";
    //public static string conString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Database.mdf;Integrated Security=True";

    public static DataSet RetrieveTable(string SQLStr)
    // Gets A table from the data base acording to the SELECT Command in SQLStr;
    // Returns DataSet with the Table.
    {
        // connect to DataBase
        SqlConnection con = new SqlConnection(conString);

        // Build SQL Query
        SqlCommand cmd = new SqlCommand(SQLStr, con);

        // Build DataAdapter
        SqlDataAdapter ad = new SqlDataAdapter(cmd);

        // Build DataSet to store the data
        DataSet ds = new DataSet();

        // Get Data form DataBase into the DataSet
        ad.Fill(ds, tblName);

        return ds;
    }

    public static object GetScalar(string SQL)
    {
        // התחברות למסד הנתונים
        SqlConnection con = new SqlConnection(conString);

        // בניית פקודת SQL
        SqlCommand cmd = new SqlCommand(SQL, con);

        // ביצוע השאילתא
        con.Open();
        object scalar = cmd.ExecuteScalar();
        con.Close();
        
        return scalar;
    }

    public static int ExecuteNonQuery(string SQL)
    {
        // התחברות למסד הנתונים
        SqlConnection con = new SqlConnection(conString);

        // בניית פקודת SQL
        SqlCommand cmd = new SqlCommand(SQL, con);

        // ביצוע השאילתא
        con.Open();
        int n = cmd.ExecuteNonQuery();
        con.Close();

        // return the number of rows affected
        return n;
    }

    public static void Delete(string[] usernameToDelete)
    // The Array "userIdToDelete" contain the id of the users to delete. 
    // Delets all the users in the array "userIdToDelete".
    {
          
        string sql = String.Format("DELETE FROM {0} WHERE username = \'", Helper.tblName);

        for (int i = 0; i < usernameToDelete.Length; i++)
        {
            ExecuteNonQuery(sql + usernameToDelete[i] + "\'");
        }
    }

    public static int Update(string username, string password)
    // The Method recieve a user objects. Find the user in the DataBase acording to his userId and update all the other properties in DB.
    {
        // HttpRequest Request
        // התחברות למסד הנתונים
        SqlConnection con = new SqlConnection(conString);

        // בניית פקודת SQL
        string sql = "UPDATE " + Helper.tblName + " SET " + string.Format("password='{1}' WHERE username='{0}'", username, password);
        //SqlCommand cmd = new SqlCommand(SQLStr, con);
        int n = ExecuteNonQuery(sql);
        return n;
    }

    public static int UpdateBestScores(string username, double cps, double wpm)
    // The Method recieve a username and new scores. Update the user's best_CPS and best_WPM in DB only if the new value is greater than the stored one.
    {
        // HttpRequest Request
        // התחברות למסד הנתונים
        SqlConnection con = new SqlConnection(conString);

        // בניית פקודת SQL
        string sql = "UPDATE " + Helper.tblName + " SET " + string.Format("best_CPS = CASE WHEN {1} > best_CPS THEN {1} ELSE best_CPS END, best_WPM = CASE WHEN {2} > best_WPM THEN {2} ELSE best_WPM END WHERE username='{0}'", username, cps, wpm);
        //SqlCommand cmd = new SqlCommand(SQLStr, con);
        int n = ExecuteNonQuery(sql);
        return n;
    }



    public static void Insert(User user)
    // The Method recieve a user objects and insert it to the Database as new row. 
    // The Method does't check if the user is already taken.
    {
        //HttpRequest Request
        // התחברות למסד הנתונים
        //string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\gilad\source\repos\DBWeb\DBWeb\App_Data\Database.mdf;Integrated Security=True";
        SqlConnection con = new SqlConnection(conString);

        // בניית פקודת SQL
        string SQLStr = String.Format("SELECT * FROM " + Helper.tblName + " WHERE 0=1");
        SqlCommand cmd = new SqlCommand(SQLStr, con);

        // בניית DataSet
        DataSet ds = new DataSet();

        // טעינת סכימת הנתונים
        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
        adapter.Fill(ds, Helper.tblName);
  
        // בניית השורה להוספה
        DataRow dr = ds.Tables[Helper.tblName].NewRow();
        dr["username"] = user.GetUsername();
        dr["password"] = user.GetPassword();
        dr["firstname"] = user.GetFirstname();
        dr["lastname"] = user.GetLastname();
        dr["birthdate"] = user.GetBirth();
        dr["gender"] = user.Getgender();
        dr["email"] = user.GetEmail();
        dr["phonenumber"] = user.GetPhonenumber();
        dr["question1"] = user.GetQuestin1();
        dr["firstanswer"] = user.GetAnswer1();
        dr["question2"] = user.GetQuestin2();
        dr["secondanswer"] = user.GetAnswer2();
        dr["admin"] = user.GetAdmin();
        dr["best_CPS"] = user.GetBestCPS();
        dr["best_WPM"] = user.GetBestWPM();
        ds.Tables[Helper.tblName].Rows.Add(dr);

        // עדכון הדאטה סט בבסיס הנתונים
        SqlCommandBuilder builder = new SqlCommandBuilder(adapter);
        adapter.UpdateCommand = builder.GetInsertCommand();
        adapter.Update(ds, tblName);
    }

    public static User GetRow(string username, string password)
  //  The Method check if there is a user with userName and Password.
    // If true the Method return a user with the first Name and Admin property.
     //If not the Method return a user wuth first name "Visitor" and Admin = false

    {
      //  התחברות למסד הנתונים
      SqlConnection con = new SqlConnection(conString);

     //   בניית פקודת SQL
        string SQL = String.Format("SELECT * FROM " + Helper.tblName +
                " WHERE username='{0}' AND password = '{1}'", username, password);
        SqlCommand cmd = new SqlCommand(SQL, con);

     //   ביצוע השאילתא
        con.Open();
        SqlDataReader reader = cmd.ExecuteReader();

      //  שימוש בנתונים שהתקבלו
       User user = new User();
       // if (reader.HasRows)
        //{
            reader.Read();
            user.SetUsername(reader.GetString(0));
            user.SetPassword(reader.GetString(1));
            user.SetFirstname(reader.GetString(2));
            user.SetLastname(reader.GetString(3));
            user.SetBirth(reader.GetDateTime(4));
            user.SetGender(reader.GetBoolean(5));
            user.SetEmail(reader.GetString(6));
            user.SetPhonenumber(reader.GetString(7));
            user.SetQuestion1(reader.GetInt32(8));
            user.SetAnswer1(reader.GetString(9));
            user.SetQuestion2(reader.GetInt32(10));
            user.SetAnswer2(reader.GetString(11));
        user.SetAdmin(reader.GetBoolean(12));
            user.SetBestCPS(reader.GetDouble(13));
            user.SetBestWPM(reader.GetDouble(14));
      //  }
      //  else
      //  {
          //  user.SetUsername("Guest");
          //  user.SetAdmin(false);
      //  }
        reader.Close();
        con.Close();
        return user;
    }




    public static string BuildUsersTable(DataTable dt)
    // the Method Build HTML user Table with checkBoxes using the users in the DataTable dt.
    {

        string str = "<table border='1' class='usersTable' align='center'>";
        str += "<tr>";
        str += "<td> </td>";
        foreach (DataColumn column in dt.Columns)
        {
            if (column.ColumnName.Equals("admin"))
                str += "<td>User Type</td>";
            else
                str += "<td>" + column.ColumnName + "</td>";
        }

        foreach (DataRow row in dt.Rows)
        {
            str += "<tr>";
            str += "<td>" + CreateRadioBtn(row["username"].ToString()) + "</td>";
            foreach (DataColumn column in dt.Columns)
            {
                if (column.ColumnName.Equals("birthDate"))
                {
                    string birth = row[column].ToString().Split(' ')[0];
                    str += "<td>" + birth + "</td>";
                }
                else if (column.ColumnName.Equals("admin"))
                {
                    if ((bool)row[column])
                        str += "<td>admin</td>";
                    else
                        str += "<td>user</td>";
                }
                else
                    str += "<td>" + row[column] + "</td>";
            }
            str += "</tr>";
        }
        str += "</tr>";
        str += "</Table>";
        return str;
    }
    public static string BuildLeaderboard(DataTable dt, string scoreColumn, string scoreHeader, string currentUsername)
    // the Method Build HTML leaderboard Table using the users in the DataTable dt (already ordered by score).
    // The row that belongs to the currentUsername gets the 'me-row' class so it can be highlighted.
    {

        string str = "<table border='1' class='usersTable' align='center'>";
        str += "<tr>";
        str += "<td>Rank</td>";
        str += "<td>Username</td>";
        str += "<td>" + scoreHeader + "</td>";
        str += "</tr>";

        int rank = 1;
        foreach (DataRow row in dt.Rows)
        {
            string rowUsername = row["username"].ToString();
            if (rowUsername.Equals(currentUsername))
                str += "<tr class='me-row'>";
            else
                str += "<tr>";
            str += "<td>" + rank + "</td>";
            str += "<td>" + rowUsername + "</td>";
            str += "<td>" + row[scoreColumn] + "</td>";
            str += "</tr>";
            rank++;
        }
        str += "</Table>";
        return str;
    }

    public static string CreateRadioBtn(string username)
    {
        return String.Format("<input type='checkbox' name='chk{0}' id='chk{0}' runat='server' />", username);
    }

    public static DataTable SortTable(DataTable dt, string column, string dir)
    {
        dt.DefaultView.Sort = column + " " + dir;
        return dt.DefaultView.ToTable();
    }

    public static DataTable FilterTable(DataTable dt, string column, string criteria)
    {
        dt.DefaultView.RowFilter = column + "=" + criteria;
        return dt.DefaultView.ToTable();
    }
}