class Admin::SessionsController < ApplicationController
  layout 'admin'

  before_action :already_signed_in?, only: [:new, :create]

  def new
  end

  def create
    admin = Admin.where(email: params[:signin][:email]).first
    
    if admin && admin.authenticate(params[:signin][:password])
      session[:admin_id] = admin.id
      redirect_to admin_root_url
    else
      render :new
    end
  end

  def destroy
    session.destroy
    redirect_to admin_root_url
  end

  private

    def already_signed_in?
      if admin_signed_in?
        flash[:alert] = "You are already signed in."
        redirect_to admin_root_url   
      end
    end
end