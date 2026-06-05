CREATE TABLE [dbo].[users] (
    [username]      NVARCHAR (50)  NOT NULL,
    [password]      NVARCHAR (50)  NOT NULL,
    [firstname]     NVARCHAR (50)  NOT NULL,
    [lastname]      NVARCHAR (50)  NOT NULL,
    [birthdate]     DATETIME       NOT NULL,
    [gender]        BIT            NULL,
    [email]         NVARCHAR (50)  NOT NULL,
    [phonenumber]   NVARCHAR (12)  NOT NULL,
    [question1]     NVARCHAR (50)  NOT NULL,
    [firstanswer]   NVARCHAR (50)  NOT NULL,
    [question2]     NVARCHAR (50)  NOT NULL,
    [secondanswer]  NVARCHAR (50)  NOT NULL,
    [admin]         BIT            DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([username] ASC)
);