SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Employees](
	[Id] [int] NOT NULL,
	[EMPId] [nvarchar](6) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Mobile] [nvarchar](10) NULL,
	[Address] [nvarchar](50) NULL,
	[Gender] [nvarchar](10) NULL,
	[Company] [nvarchar](50) NULL,
	[Designation] [nvarchar](25) NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO

CREATE PROCEDURE [dbo].[Usp_InsertUpdateDelete_Employees]  
@ID BIGINT = 0
,@Name NVARCHAR(100) = NULL
,@Mobileno NVARCHAR(15) = NULL
,@Address NVARCHAR(300) = 0
,@Company NVARCHAR(50) = NULL
,@Gender NVARCHAR(10) = NULL
,@Designation NVARCHAR(50) = NULL
,@Query INT
AS
BEGIN
 declare @EMPId as [nvarchar](6)
IF (@Query = 1)
BEGIN
select @ID = isnull(max(ID),0) + 1 from employees
set @EMPId = 'RCT0' + ltrim(@ID)

INSERT INTO Employees(
ID
,[EMPId]
,Name
,Mobile
,[Address]
,Gender
,Company
,Designation
)
VALUES (
@ID
,@EMPId
,@Name
,@Mobileno 
,@Address 
,@Gender
,'Rencata'
,@Designation
)
 
IF (@@ROWCOUNT > 0)
BEGIN
SELECT 'Inserted'
END
END
 
IF (@Query = 2)
BEGIN
UPDATE Employees
SET NAME = @Name
,[Address] = @Address
,Mobile = @Mobileno
,Gender = @Gender
,Designation = @Designation
WHERE Employees.ID = @ID
 
SELECT 'Updated'
END
 
IF (@Query = 3)
BEGIN
DELETE
FROM Employees
WHERE Employees.ID = @ID
 
SELECT 'Deleted'
END
 
IF (@Query = 4)
BEGIN
SELECT *
FROM Employees
END
END
 
IF (@Query = 5)
BEGIN
SELECT *
FROM Employees
WHERE Employees.ID = @ID
END