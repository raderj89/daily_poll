# Daily Poll

Built in one week (June 16 - June 23, 2014) during my apprenticeship at [DevShop](www.nycdevshop.com).

## Install

1. Clone the repository.
2. Run `bundle install`
3. Remove the .example extensions from database.yml and secrets.yml, putting in your own credentials.
4. Put in your Twilio credentials inside secrets.yml and twilio_config.rb

If you want to see the app with seed data:

5. Comment out `after_save :subscribe_message` and its corresponding method in the user model (so Twilio doesn't try to send messages to the fake users)
6. Run `rake db:seed`
7. Uncomment the methods above.