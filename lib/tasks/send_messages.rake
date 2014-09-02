namespace :send_messages do
  desc "sends out daily poll to all users"
  task daily_poll: :environment do
    TwilioMessenger.new.send_message
  end
end
