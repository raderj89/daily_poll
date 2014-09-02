module PagesHelper

  def previous_poll(poll)
    previous_polls = Poll.where("release_date < ?", poll.release_date)
    previous_polls.empty? ? poll.question : previous_polls.first.question
  end

  def next_poll(poll)
    next_polls = Poll.where('release_date > ?', poll.release_date) 
    if next_polls.empty? || poll.release_date == Date.today - 1.day
      poll.question 
    else 
      next_polls.find_by(release_date: poll.release_date + 1.day).question
    end
  end

  def box_height(yes_no_votes, total_votes)
    if total_votes < 1
      return 0
    else
      380 * yes_no_votes / total_votes
    end
  end

end