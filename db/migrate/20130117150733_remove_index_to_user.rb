class RemoveIndexToUser < ActiveRecord::Migration
  def up
    remove_index :users, :name => :index_users_on_plan_id
    remove_index :users, :name => :index_users_on_previous_plan_id
  end

  def down   
    add_index :users, :name => :index_users_on_plan_id
    add_index :users, :name => :index_users_on_previous_plan_id
  end
end
