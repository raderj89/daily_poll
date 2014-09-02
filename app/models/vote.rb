class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :poll
  
  validates_uniqueness_of :user_id, scope: :poll_id
end
