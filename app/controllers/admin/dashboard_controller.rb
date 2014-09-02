class Admin::DashboardController < Admin::ApplicationController
  layout 'admin'
  before_action :require_admin_signin!

  def index
    @yesterday_poll = Poll.find_by(release_date: (Date.today - 1.day))
    @today_poll = Poll.find_by(release_date: Date.today) 

    @later_polls = Poll.admin
  end
end