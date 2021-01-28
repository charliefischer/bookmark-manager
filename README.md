# Bookmark Manager

This code is intended as a supplementary guide for [bookmark manager](https://github.com/makersacademy/course/tree/master/bookmark_manager). The commits on master branch roughly correspond with the walkthroughs provided in the challenge.

## User Stories

```
As a time-pressed user
So that I can quickly go to web sites I regularly visit
I would like to see a list of bookmarks
```

```
As a time-pressed user
So I can remove websites I'm no longer interested in
I would like to delete bookmarks from the table
```

## Domain Model

![Bookmark Manager domain model](./public/images/bookmark_manager_1.png)


## How to use

### To set up the project

Clone this repository and then run:

```
bundle
```

### To set up the database

Connect to `psql` and create the `bookmark_manager` database:

```
CREATE DATABASE bookmark_manager;
```

To set up the appropriate tables, connect to the database in `psql` and run the SQL scripts in the `db/migrations` folder in the given order.

### To run the Bookmark Manager app:

```
ruby app.rb
```

To view bookmarks, navigate to `localhost:4567/bookmarks`.

### To run tests:

```
rspec
```
