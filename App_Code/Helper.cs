using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public static class Helper 
{
    public const string DBName = "Database.mdf";
    public const string tblName = "users";
    public const string conString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\"
                                    + DBName + ";Integrated Security=True";


    // `parameters` is optional (via `params`), so every existing call site that
    // passes a bare SQL string still compiles and runs unchanged. Callers that
    // build a query from user input should switch to @-placeholders and pass
    // the values here instead of concatenating them into the SQL string.
    public static DataSet RetrieveTable(string SQLStr, params SqlParameter[] parameters)
    {
        SqlConnection con = new SqlConnection(conString);

        SqlCommand cmd = new SqlCommand(SQLStr, con);
        if (parameters != null && parameters.Length > 0)
            cmd.Parameters.AddRange(parameters);

        SqlDataAdapter ad = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();

        ad.Fill(ds, tblName);

        return ds;
    }

    public static object GetScalar(string SQL, params SqlParameter[] parameters)
    {
        SqlConnection con = new SqlConnection(conString);

        SqlCommand cmd = new SqlCommand(SQL, con);
        if (parameters != null && parameters.Length > 0)
            cmd.Parameters.AddRange(parameters);

        con.Open();
        object scalar = cmd.ExecuteScalar();
        con.Close();

        return scalar;
    }

    public static int ExecuteNonQuery(string SQL, params SqlParameter[] parameters)
    {
        SqlConnection con = new SqlConnection(conString);

        SqlCommand cmd = new SqlCommand(SQL, con);
        if (parameters != null && parameters.Length > 0)
            cmd.Parameters.AddRange(parameters);

        con.Open();
        int n = cmd.ExecuteNonQuery();
        con.Close();

        return n;
    }

    public static void Delete(string[] usernameToDelete)
    {
        string sql = String.Format("DELETE FROM {0} WHERE username = @username", Helper.tblName);

        for (int i = 0; i < usernameToDelete.Length; i++)
        {
            ExecuteNonQuery(sql, new SqlParameter("@username", usernameToDelete[i]));
        }
    }

    public static int Update(string username, string password)
    {
        string sql = "UPDATE " + Helper.tblName + " SET password = @password WHERE username = @username";
        int n = ExecuteNonQuery(sql,
            new SqlParameter("@password", password),
            new SqlParameter("@username", username));
        return n;
    }

    public static int UpdateBestScores(string username, double cps, double wpm)
    {
        string sql = "UPDATE " + Helper.tblName + " SET " +
            "best_CPS = CASE WHEN @cps > best_CPS THEN @cps ELSE best_CPS END, " +
            "best_WPM = CASE WHEN @wpm > best_WPM THEN @wpm ELSE best_WPM END " +
            "WHERE username = @username";
        int n = ExecuteNonQuery(sql,
            new SqlParameter("@cps", cps),
            new SqlParameter("@wpm", wpm),
            new SqlParameter("@username", username));
        return n;
    }



    public static void Insert(User user)
    {
        SqlConnection con = new SqlConnection(conString);

        string SQLStr = String.Format("SELECT * FROM " + Helper.tblName + " WHERE 0=1");
        SqlCommand cmd = new SqlCommand(SQLStr, con);

        DataSet ds = new DataSet();

        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
        adapter.Fill(ds, Helper.tblName);
  
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

        SqlCommandBuilder builder = new SqlCommandBuilder(adapter);
        adapter.UpdateCommand = builder.GetInsertCommand();
        adapter.Update(ds, tblName);
    }

    public static User GetRow(string username, string password)

    {
      SqlConnection con = new SqlConnection(conString);

        string SQL = "SELECT * FROM " + Helper.tblName + " WHERE username = @username AND password = @password";
        SqlCommand cmd = new SqlCommand(SQL, con);
        cmd.Parameters.AddWithValue("@username", username);
        cmd.Parameters.AddWithValue("@password", password);

        con.Open();
        SqlDataReader reader = cmd.ExecuteReader();

       User user = new User();
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
        reader.Close();
        con.Close();
        return user;
    }




    public static string BuildUsersTable(DataTable dt)
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