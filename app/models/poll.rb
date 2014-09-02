class Poll < ActiveRecord::Base
  has_many :votes, dependent: :destroy

  validates :question, presence: true, uniqueness: true
  validates :release_date, presence: true
  validates_uniqueness_of :release_date, on: :create

  scope :admin, -> { where("release_date > ?", Date.today).order('release_date ASC') }

  scope :archive, -> { where('release_date < ?', Date.today).order('release_date DESC') }

  def yes_count
    votes.where(answer: 1).count
  end

  def yes_percent
    percent = ((self.yes_count / votes.count.to_f) * 100)
    percent.nan? ? 0 : percent
  end

  def no_count
    votes.where(answer: 2).count
  end

  def no_percent
    percent = ((self.no_count / votes.count.to_f) * 100)
    percent.nan? ? 0 : percent
  end

  def total_votes
    votes.count
  end

  class << self
    def today_poll
      poll = find_by(release_date: Date.today)
      return "Today's question: #{poll.question} Respond with 'yes' or 'no' to vote." unless poll.nil?
    end
  end
end
