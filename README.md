# Ruby on Rails + AngularJS meal ordering app

## App on heroku
[*meal-ordering.herokuapp.com*](meal-ordering.herokuapp.com)

## Setup
Follow these steps to setup the application:

### Step 1: Install gems
```
$ bundle install
```

### Step 2: figaro
Create a renamed copy of the application.yml.sample file in config folder.
```
$ cp config/application.yml.sample config/application.yml


### Step 3: Add your Facebook environment variables
It is necessary to add Facebook variables to `config/application.yml`. You have to setup your own Facebook application on [facebook developers](developers.facebook.com).
```
# config/application.yml

development:
  FACEBOOK_KEY: "your_facebook_key"
  FACEBOOK_SECRET: "your_facebook_secret"

```

### Step 4: Create database and run migrations
```
$ rake db:setup
```

## Test
### To test Rails controllers and models:
```
$ rspec
```

### To test JavaScripts:
* run Rails server
```
$ rails s
```

* run tests in browser
```
http://localhost:3000/jasmine
```
