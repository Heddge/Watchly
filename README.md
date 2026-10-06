# Watchly

A web application for managing a personal library of movies, games, and books.

Watchly allows users to store items in their personal library, rate them, track their status, and receive personalized recommendations.

## Features

* User registration and authentication
* Movies, games, and books
* Personal user libraries
* Search and filtering
* Ratings from 1 to 10
* Status tracking: Want, In Progress, Completed
* Personalized recommendations
* Library statistics

## Tech Stack

* Ruby on Rails
* PostgreSQL
* HTML / CSS
* JavaScript
* bcrypt

## Database

Main entities:

```text
User
  |
  v
UserItem ----> Item
                |
                v
              Genre
```

Each user has a private library. Catalog items can be shared between multiple users.

## Getting Started

Install dependencies:

```bash
bundle install
```

Create the database:

```bash
rails db:create
rails db:migrate
```

Start the development server:

```bash
rails server
```

Open the application at:

```text
http://localhost:3000
```

## Project Status

In development.

This project is being developed as a university web development project.
