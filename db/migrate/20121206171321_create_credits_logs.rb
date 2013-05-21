class CreateCreditsLogs < ActiveRecord::Migration
  def change
    create_table :credits_logs do |t|
      t.integer :previous_credits
      t.integer :new_credits
      t.integer :user_id
      t.integer :previous_plan_id
      t.integer :new_plan_id

      t.timestamps
    end
  end
end
