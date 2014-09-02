class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :question
      t.date :release_date

      t.timestamps
    end
  end
end
