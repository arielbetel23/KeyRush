using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public class User
{
    private string username;
    private string password;
    
    private string firstname;
    private string lastname;
    private DateTime birth;
    private bool gender;
    private string email;
    private string  phonenumber;
    private int question1;
    private string answer1;
    private int question2;
    private string answer2;

    private bool admin;

    private double bestCPS;
    private double bestWPM;
    public User(string username, string password, string firstname, string lastname, DateTime birth, bool gender, string email, string phonenumber, bool admin, int question1, string answer1, int question2, string answer2, double bestCPS, double bestWPM)
    {
        this.username = username;
        this.password = password;
        this.firstname = firstname;
        this.lastname = lastname;
        this.birth = birth;
        this.gender = gender;
        this.email = email;
        this.phonenumber = phonenumber;
        this.question1 = question1;
        this.answer1 = answer1;
        this.question2 = question2;
        this.answer2 = answer2;
        this.admin = admin;
        this.bestCPS = bestCPS;
        this.bestWPM = bestWPM;
    }
    public User()
    {
        username = "";
        password = "";
        firstname = "";
        lastname = "";
        birth = DateTime.Now;
        email = "";
        phonenumber = "";
        answer1 = "";
        answer2 = "";
        question1 = 1;
        question2 = 1;
        admin = false;
        gender = true;
        bestCPS = 0;
        bestWPM = 0;
    }
    public string GetUsername()
    {
        return this.username;
    }
    public string GetPassword()
    {
        return this.password;
    }
    public string GetFirstname()
    {
        return this.firstname;
    }
    public string GetLastname()
    {
        return this.lastname;
    }
    public bool Getgender()
    {
        return this.gender;
    }
   public DateTime GetBirth()
   {
        return this.birth;
    }
    public string GetEmail()
    {
        return this.email;
    }
    
    public string GetPhonenumber()
    {
        return this.phonenumber;
    }
    
    public int GetQuestin1()
    {
        return this.question1;
    }

    public int GetQuestin2()
    {
        return this.question2;
    }
    public string GetAnswer1()
    {
        return this.answer1;
    }


    public string GetAnswer2()
    {
        return this.answer2;
    }

    public void SetQuestion1(int num)
    {
        this.question1 = num;
    }

    public void SetQuestion2(int num)
    {
        this.question2 = num;
    } 

    

    public bool GetAdmin()
    {
        return this.admin;
    }

    public void SetAnswer1(string other)
    {
        this.answer1 = other;
    }

    public void SetAnswer2(string other)
    {
        this.answer2 = other;
    }

    
    public void SetUsername(string username)
    {
        this.username = username;
    }
    public void SetPassword(string password)
    {
        this.password = password;
    }
    public void SetFirstname(string firstname)
    {
        this.firstname = firstname;
    }
    public void SetLastname(string lastname)
    {
        this.lastname = lastname;
    }
    public void SetBirth(DateTime birth)
    {
        this.birth = birth;
    }
    public void SetGender(bool gender)
    {
        this.gender = gender;
    }
    public void SetEmail(string email)
        {
            this.email = email;
       }
public void SetPhonenumber(string phonenumber)
{
    this.phonenumber = phonenumber;
}


public void SetAdmin(bool admin)
{
    this.admin = admin;
}

    public double GetBestCPS()
    {
        return this.bestCPS;
    }

    public double GetBestWPM()
    {
        return this.bestWPM;
    }

    public void SetBestCPS(double bestCPS)
    {
        this.bestCPS = bestCPS;
    }

    public void SetBestWPM(double bestWPM)
    {
        this.bestWPM = bestWPM;
    }



}