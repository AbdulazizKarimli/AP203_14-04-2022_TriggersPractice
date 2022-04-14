CREATE DATABASE AP203Course

USE AP203Course

CREATE TABLE Students(
	Id INT PRIMARY KEY IDENTITY,
	Fullname NVARCHAR(100)
)

CREATE TRIGGER SelectAfterInsert
ON Students
AFTER INSERT
AS
BEGIN
	SELECT * FROM Students
END

INSERT INTO Students
VALUES ('Seymur Mustafayev')

INSERT INTO Students (Fullname)
VALUES ('Rovshen Amiraslanov')

ALTER TABLE Students
ADD IsDeleted BIT DEFAULT 'false'

CREATE TRIGGER SoftDelete
ON Students
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @Id INT
	SELECT @Id=Id FROM deleted
	UPDATE Students SET IsDeleted = 'true'
	WHERE Id = @Id
END

DELETE FROM Students
WHERE Id = 1

ALTER TABLE Students
ADD ModificationDate DATETIME2 DEFAULT GETDATE()

INSERT INTO Students (Fullname)
VALUES ('Ferid Shixaliyev')


CREATE TRIGGER UpateModificationDate
ON Students
AFTER UPDATE
AS
BEGIN
	DECLARE @Id INT
	SELECT @Id=Id FROM inserted
	UPDATE Students SET ModificationDate = GETDATE()
	WHERE Id = @Id
END

UPDATE Students
SET Fullname = 'Shukran Shirinov'
WHERE Id=3

CREATE TABLE StudentsCopy(
	Id INT,
	Fullname NVARCHAR(100)
)

CREATE TRIGGER InsertToBackup
ON Students
AFTER INSERT
AS
BEGIN
	DECLARE @Id INT, @Fullname NVARCHAR(100)
	SELECT @Id=Id, @Fullname=Fullname FROM inserted
	INSERT INTO StudentsCopy
	VALUES (@Id, @Fullname)
END

INSERT INTO Students (Fullname)
VALUES ('Mushvig Shukurov')