class Admin::PollsController < Admin::ApplicationController
  inherit_resources
  
  def create
    create! { admin_root_path }
  end

  def sort
    current_dates = Poll.admin.pluck(:release_date)

    params[:poll].each_with_index do |id, index|
      poll = Poll.find_by(id: id)
      poll.update(release_date: current_dates[index])
    end

    render json: { dates: current_dates }
  end

  private

    def poll_params
      params.require(:poll).permit(:question, :release_date)
    end

end