class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :answer
      t.belongs_to :user
      t.belongs_to :poll
      
      t.timestamps
    end
  end
end
