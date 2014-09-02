class UsersController < ApplicationController

  def create
    @user = User.new(user_params)

    if @user.save
      render json: { status: 'success', user_count: User.all.count }
    else
      @user = User.new
      @poll = Poll.last
      render json: { status: 'failure' }
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :phone)
    end

end