class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :administrator, :boolean
    add_column :users, :credits, :integer, :default => 0
    add_column :users, :plan_id, :integer
    add_column :users, :previous_plan_id, :integer
    add_column :users, :terms_of_service, :boolean, :default => false
    
    add_index :users, :plan_id, :unique => true
    add_index :users, :previous_plan_id, :unique => true
  end
end
