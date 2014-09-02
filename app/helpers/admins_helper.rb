module AdminsHelper

  def poll_today(poll)
    poll.nil? ? "There's no poll today" : poll.question
  end
  
end
