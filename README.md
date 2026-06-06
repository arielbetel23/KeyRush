# KeyRush ⌨️

A web-based platform for testing and improving your typing speed and click speed, with global leaderboards and personal best tracking.

---

## Features

- **Typing Speed Test** — Measure your WPM (words per minute) across multiple time durations. Scores are saved automatically and compared against your personal best.
- **CPS Test** — Measure your clicks per second in a fast-paced click challenge.
- **Global Leaderboard** — Compete with all registered users on both the typing and CPS tests. Your current rank is highlighted live on the leaderboard.
- **Personal Best Tracking** — The database stores your all-time best WPM and CPS. Your homepage displays your stats when you're signed in.
- **User Authentication** — Full sign-up, sign-in, and forgot-password flow with two security questions.
- **Admin Panel** — Admin accounts have access to user management features.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | HTML, CSS, Bootstrap 5, JavaScript |
| Backend | ASP.NET WebForms (C#) |
| Database | Microsoft SQL Server |
| Data Access | ADO.NET (custom Helper class) |
| Communication | AJAX (fetch API) for score submission |

---

## Getting Started

### Prerequisites

- Visual Studio 2019 or later
- SQL Server (LocalDB or full instance)
- .NET Framework 4.x

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/arielbetel23/KeyRush.git
   ```

2. Open `KeyRush_project.sln` in Visual Studio.

3. In SQL Server, create a new database and run the schema below to set up the `users` table.

4. Update the connection string in `Web.config` to point to your database.

5. Build and run the project (`F5` or `Ctrl+F5`).

---

## Database Schema

```sql
CREATE TABLE [dbo].[users] (
    [username]     NVARCHAR (50)  NOT NULL,
    [password]     NVARCHAR (50)  NOT NULL,
    [firstname]    NVARCHAR (50)  NOT NULL,
    [lastname]     NVARCHAR (50)  NOT NULL,
    [birthdate]    DATETIME       NOT NULL,
    [gender]       BIT            DEFAULT (NULL) NULL,
    [email]        NVARCHAR (50)  NOT NULL,
    [phonenumber]  NVARCHAR (12)  NOT NULL,
    [question1]    INT            NOT NULL,
    [firstanswer]  NVARCHAR (50)  NOT NULL,
    [question2]    INT            NOT NULL,
    [secondanswer] NVARCHAR (50)  NOT NULL,
    [admin]        BIT            DEFAULT ((0)) NOT NULL,
    [best_CPS]     FLOAT          DEFAULT ((0)) NOT NULL,
    [best_WPM]     FLOAT          DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([username] ASC)
);
```

---

## Project Background

KeyRush started as a video games website built for a CS finals project in 8th grade using ASP.NET WebForms. The entire platform was later redesigned and rebuilt as a typing and CPS testing tool, keeping the same backend infrastructure while replacing all the content, pages, and database structure.

The redesign involved:
- Deleting all old video game pages and content
- Redesigning the homepage as a proper landing page
- Building the typing test and CPS test pages from scratch
- Adding a global leaderboard system to both tests
- Extending the database with personal best columns
- Rewriting the About page and updating the entire site's visual theme

---

## Pages

| Page | Description |
|---|---|
| `Homepage.aspx` | Homepage — hero section, feature cards, personal stats (when signed in) |
| `Typing.aspx` | Typing speed test with timer, word display, results, and leaderboard |
| `CPS.aspx` | Click speed test with live counter, results, and leaderboard |
| `About.aspx` | Platform info and how it works |
| `SignIn.aspx` | Login page |
| `SignUp.aspx` | Registration page |
| `ForgotPassword.aspx` | Password reset via security questions |
| `EditUser.aspx` | Edit account details |
| `Admin.aspx` | Admin-only user management |

---

## Author

**Ariel Betel** — [github.com/arielbetel23](https://github.com/arielbetel23)
