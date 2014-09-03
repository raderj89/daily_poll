# Daily Poll

Daily Poll is a fun polling app built in one week (June 16 - June 23, 2014) during my apprenticeship at [DevShop](www.nycdevshop.com).

## Install

1. Clone the repository.
2. Run `bundle install`.
3. Remove the .example extensions from database.yml and secrets.yml, putting in your own credentials.
4. Put in your Twilio credentials inside secrets.yml and twilio_config.rb.
5. Run `rake db:create && rake db:migrate`.

If you want to see the app with seed data:

6. Comment out `after_save :subscribe_message` and its corresponding method in the user model (so Twilio doesn't try to send messages to the fake users).
7. Run `rake db:seed`.
8. Uncomment the methods above.
