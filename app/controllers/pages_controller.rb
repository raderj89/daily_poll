class PagesController < ApplicationController
  def home
    @user = User.new
    @latest_poll = Poll.find_by(release_date: (Date.today - 1.day).to_s)
    @polls = Poll.archive
  end

  def show_poll
    @archived_poll = Poll.find_by(question: params[:question])
    render partial: '/pages/poll', locals: { poll: @archived_poll }
  end

end
