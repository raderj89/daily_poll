require 'ffaker'

Poll.delete_all
Vote.delete_all
Admin.delete_all

Admin.create!(email: 'admin@example.com', password: 'password')

Poll.create!(question: Faker::HipsterIpsum.sentence.gsub!(/\./, '?'), release_date: (Date.today).to_s)

24.times do |i|
  number_days = i + 1
  Poll.create!(question: "#{Faker::HipsterIpsum.sentence.gsub!(/\./, '?')}", release_date: ( Date.today - number_days.day ).to_s)
  Poll.create!(question: "#{Faker::HipsterIpsum.sentence.gsub!(/\./, '?')}", release_date: ( Date.today + number_days.day ).to_s)
end

100.times do |i|
  User.create!(name: Faker::Name.name, phone: Faker::PhoneNumber.phone_number)
end

Poll.all.each do |poll|
  User.all.each do |user| 
    vote = Vote.create!(answer: rand(2) + 1, poll_id: poll.id, user_id: user.id)
  end
end
