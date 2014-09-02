class Admin::ApplicationController < ApplicationController

  layout 'admin'
  before_action :require_admin_signin!

end
