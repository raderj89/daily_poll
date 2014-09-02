class TwilioMessenger
  attr_reader :poll

  def initialize
    @poll = Poll.find_by(release_date: Date.today)
  end

  def send_message
    client = setup_client

    from = Rails.application.secrets.twilio_phone_number

    friends = Hash[User.pluck(:phone, :name)]

    friends.each do |key, value|
      client.account.messages.create(
        from: from,
        to: key,
        body: "Hey, #{value}, #{poll.question}"
      )

    end
  end

  def setup_client
    Twilio::REST::Client.new(Rails.application.secrets.twilio_sid,
                             Rails.application.secrets.twilio_token)
  end
end