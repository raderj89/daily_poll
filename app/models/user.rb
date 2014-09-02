class User < ActiveRecord::Base
  has_many :votes
  
  before_validation :format_number

  validates :name, presence: true
  validates :phone, presence: true, uniqueness: true

  after_save :subscribe_message

  private

    def format_number
      self.phone = self.phone.gsub(/\D/, "") if self.phone =~ /\D/
      self.phone = '+1' + self.phone
    end

    def subscribe_message
      client = setup_client

      from = Rails.application.secrets.twilio_phone_number

      client.account.messages.create(
        from: from,
        to: self.phone,
        body: "You've been subscribed to Daily Poll! " +
              "#{Poll.today_poll unless Poll.today_poll.nil?} " +
              "If you wish to unsubscribe at any time, just text back 'unsubscribe'."
      )
    end
    
    def setup_client
      Twilio::REST::Client.new(Rails.application.secrets.twilio_sid,
                               Rails.application.secrets.twilio_token)
    end

end
