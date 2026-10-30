# Movie Generator Database

A university group project that designs and implements a relational database for a movie recommendation and watching system using **SQL (MySQL)**. It stores movies, directors, users, and which movies each user has watched.

## Database Design

The database movie_generator has four tables:

| Table | Description |
|---|---|
| `Movie` | Movie name, category (Action, Drama, Comedy, Horror, Animation), age group, and its director |
| `Director` | Director name and date of birth |
| `Users` | User name, date of birth, and unique email |
| `Watches` | Links users to the movies they watched (many-to-many relationship) |

## Features

- **Relationships:** primary keys, composite primary key, and foreign keys with `ON DELETE SET NULL` and `ON DELETE CASCADE`
- **Constraints:** `NOT NULL`, `UNIQUE` (user email), `DEFAULT` (age group), and `CHECK` (user date of birth)
- **Queries:**
  - Filter movies by age group
  - Count how many times each movie was watched (`LEFT JOIN` with `GROUP BY`)
  - Calculate the average age of users who watched each movie
  - Show each movie with its director (`INNER JOIN`)
  - Find movies watched by a specific user (subquery)
- **View:** `UserMovieReport`, which lists each user with the movies they watched

## Technologies

- SQL
- MySQL

## My Contribution

This was a group project. I was responsible for theg **Watches** table, which connects users to the movies they watched.
