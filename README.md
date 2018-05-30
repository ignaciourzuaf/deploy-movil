# README

Note: You may need to use `sudo` to each call to `docker` or `docker-compose`

### System dependencies and versions
* ruby
* rails
* docker-compose
* TODO

### Setup
* Set environment variables: create a file called `.env`, with:
  ```
  POSTGRES_PASSWORD=<password>
  POSTGRES_HOST=postgresql
  ```
  Note: `POSTGRES_HOST` must be `postgresql` for running with dockers, and must be `localhost` for running directly with `rails s`.

* Building dockers: `docker-compose build`

* Install gems: `docker-compose run web bundle install`. Apparently, after installing gems a re-build is needed.
  See here for improving this: http://bradgessler.com/articles/docker-bundler/ (TODO)

* Setting up the database:
```
  docker-compose run web rails db:create
  docker-compose run web rails db:migrate
```

* Running the server: `docker-compose up`. Add `-d` to run in background

* Shutting the server down: `docker-compose down`

* In general, to run any command inside docker: `docker-compose run web <command>`, e.g. `rails routes`

### Linter
* Run `rubocop`, use `-a` option to apply automatic fixes when possible

### Tests
* Run `docker-compose run web bundle exec rspec`
* A summary of the coverage will be displayed in the console. To see the full detail of the coverage open the `coverage/index.html` in chrome



### Deploy
* Install the heroku CLI, and login with your account
* Run `heroku git:remote -a obs-api` to add the heroku remote to the app
* Run `heroku container:push web` to push your current branch to heroku. If your docker needs `sudo` this command will also need it.



### Opening docker shells

#### Web service  
* When the service is running open a bash shell using: `docker exec -ti backend_web_1 /bin/bash`

#### Connect to postgres database  
* When the postgres service is running open a bash shell using: `docker exec -ti backend_postgresql_1 /bin/bash`, you'll be inside the postgres service.
* Then run: `psql -U postgres -d <database-name>`, where `<database-name>` may be `backend_development` or `backend_test`



### Common errors
* If the web service is not shutdown correctly, it may leave the docker on a bad state and prevent it from running the next time. If `docker-compose ps` shows you that the web service is down and still you get a:
  ```
  A server is already running. Check /papinotas/tmp/pids/server.pid.
  ```
  Run: `rm ./tmp/pids/server.pid`. This will delete the file that is telling docker that the server is running.

* [Add more common errors here]
