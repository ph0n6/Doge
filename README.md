# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* Services (job queues, cache servers, search engines, etc.)

## How to run the test suite
```
rspec spec
```

## Deployment instructions
  ```
  bundle install
  
  rails db:create
  
  rails db:migrate
  
  rails db:seed
  ```

## Note:

  * FactoryGirl deprecated -> change all to FactoryBot (gem 'factory_girl_rails' -> gem 'factory_bot_rails')
  * Because of stub() deprecated : 'helper.stub(:user_signed_in?)' -> 'allow(helper).to receive(:user_signed_in?)'
  * Remember to run 'sudo apt install phantomjs' or for MAC USER : 'brew install phantomjs'
