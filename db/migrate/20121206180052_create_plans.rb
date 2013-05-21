class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :maximum_customers
      t.decimal :price

      t.timestamps
    end
  end
end
