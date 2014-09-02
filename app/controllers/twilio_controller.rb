require 'twilio-ruby'

class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :load_poll, :load_user, :format_response

  def process_sms
    case response
      when 'yes' 
        @vote = @poll.votes.build(answer: 1)
        @vote.user = @user
        @vote.save

        render 'process_sms.xml.erb', :content_type => 'text/xml'

      when 'no'
        @vote = @poll.votes.build(answer: 2)
        @vote.user = @user
        @vote.save

        render 'process_sms.xml.erb', :content_type => 'text/xml'

      when 'unsubscribe'
        render 'unsubscribe.xml.erb', :content_type => 'text/xml'

        @user.destroy

      else
        render 'error.xml.erb', :content_type => 'text/xml'
    end
  end

  private
  
    def load_poll
      @poll = Poll.find_by(release_date: Date.today.to_s)
    end

    def load_user
      @user = User.find_by(phone: params["From"])
    end

    def format_response
      response = params["Body"].downcase.gsub(/\s/, '')
    end
end