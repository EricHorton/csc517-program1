# CSC 517 Program 1 - Class Portal

This application is an example Ruby on Rails app deployed to [Heroku](https://docs.google.com/document/d/1xmeH4MAlUs6QfPoC4J4bsMKYWkawDZrsZDFM7S1G8ag/edit).
You can view the [requirements](https://docs.google.com/document/d/1xmeH4MAlUs6QfPoC4J4bsMKYWkawDZrsZDFM7S1G8ag/edit) in google docs.

## Recommended Build Environment
It is recommended to use rbenv and ruby-build to install a non-system version of ruby. A package manager like homebrew can be used for installation
```
brew isntall rbenv ruby-build
rbenv install 2.3.0
```
See [rbenv](https://github.com/rbenv/rbenv#installation) for configuration instructions.

## PostgreSQL
Portal requires an installation of Postgres and hooks up with Heroku Postgres on deployment. Install the latest version of Postgres and create the development and test databases.
```
$ psql
# create database portal_development;
# create database portal_test;
```

## RubyMine
Development through RubyMine is recommended. To start the Rails server use Run > Development: portal.