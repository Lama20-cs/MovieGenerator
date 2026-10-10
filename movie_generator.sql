CREATE DATABASE movie_generator;
show databases;

USE movie_generator;

CREATE TABLE Movie (
MovieID int PRIMARY KEY ,
MovieName VARCHAR(40) NOT NULL,
MovieCategory ENUM ('Action','Drama','Comedy','Horror','Animation') NOT NULL ,
MovieAgeGroup VARCHAR(20)  DEFAULT 'PG' NOT NULL  , 
DirectorID INT NULL,
FOREIGN KEY (DirectorID) REFERENCES Director(DirectorID) ON DELETE SET NULL
);
describe Movie;

CREATE TABLE Director (
    DirectorID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DirectorDateOfBirth DATE
);
describe Director;


CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    UserDateOfBirth DATE CHECK (UserDateOfBirth < '2016-01-01'),
    UserEmail VARCHAR(100) UNIQUE NOT NULL
);
describe Users;


CREATE TABLE Watches (
    MovieID INT,
    UserID INT,
    PRIMARY KEY (MovieID, UserID),
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID) ON DELETE CASCADE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);
describe Watches;

INSERT INTO Director (DirectorID, FirstName, LastName, DirectorDateOfBirth) VALUES
(1, 'Chris', 'Columbus', '1958-09-10'),
(2, 'Roger', 'Allers', '1949-06-29'),
(3, 'Don', 'Bluth', '1937-09-13'),
(4, 'Agnieszka', 'Holland', '1948-11-28'),
(5, 'Henry', 'Selick', '1952-11-30');

 SELECT * FROM Director;


INSERT INTO Users (UserID, FirstName, LastName, UserDateOfBirth, UserEmail) VALUES
(1, 'Lana', 'Fahad', '2001-05-10', 'lana@outlook.com'),
(2, 'Sara', 'Ali', '2006-11-20', 'sara@outlook.com'),
(3, 'Ahmed', 'Salem', '2005-01-15', 'ahmed@outlook.com'),
(4, 'Fahad', 'Khalid', '2010-03-30', 'fahad@outlook.com'),
(5, 'Farah', 'Nasser', '2014-07-12', 'farah@outlook.com');

 SELECT * FROM Users;

INSERT INTO Movie (MovieID, MovieName, MovieCategory, MovieAgeGroup, DirectorID) VALUES
(1, 'Harry Potter', 'Action', 'PG', 1),
(2, 'The Lion King', 'Animation', 'G', 2),
(3, 'Anastasia', 'Drama', 'G', 3),
(4, 'The Secret Garden', 'Comedy', 'G', 4),
(5, 'Coraline', 'Horror', 'PG', 5);

 SELECT * FROM Movie;

INSERT INTO Watches (MovieID, UserID) VALUES
(1, 1),
(2, 3),
(3, 2),
(4, 5),
(5, 4);

 SELECT * FROM Watches;
 
SELECT FirstName, LastName
FROM Users
WHERE UserID = 1;

SELECT MovieName, MovieCategory
FROM Movie
WHERE MovieAgeGroup = 'PG';

SELECT m.MovieName, COUNT(w.UserID) AS Total_Watches
FROM Movie m
LEFT JOIN Watches w ON m.MovieID = w.MovieID
GROUP BY m.MovieName;

SELECT m.MovieName,
AVG(TIMESTAMPDIFF(YEAR, u.UserDateOfBirth, CURDATE())) AS Avg_User_Age
FROM Watches w
JOIN Users u ON w.UserID = u.UserID
JOIN Movie m ON w.MovieID = m.MovieID
GROUP BY m.MovieName;

SELECT m.MovieName, d.FirstName, d.LastName
FROM Movie m
INNER JOIN Director d ON m.DirectorID = d.DirectorID;

SELECT MovieName
FROM Movie
WHERE MovieID IN (
    SELECT MovieID
    FROM Watches
    WHERE UserID = 1
);

CREATE VIEW UserMovieReport AS
SELECT Users.FirstName, Users.LastName, Movie.MovieName
FROM Users
JOIN Watches ON Users.UserID = Watches.UserID
JOIN Movie ON Watches.MovieID = Movie.MovieID;

SELECT * FROM UserMovieReport;