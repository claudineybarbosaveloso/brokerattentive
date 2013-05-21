class CreateConsolidates < ActiveRecord::Migration
  def change
    create_table :consolidates do |t|
      t.references :user, :null => false
      t.string :name
      t.integer :registration, :null => false
      t.integer :series, :null => false
      t.integer :proposal, :null => false
      t.string :code_beneficiary, :null => false
      t.integer :plan, :null => false
      t.integer :number_quota, :null => false
      t.decimal :value_contribution, :precision => 8, :scale => 2
      t.decimal :commission_percentage, :precision => 8, :scale => 2
      t.decimal :commission_value, :precision => 8, :scale => 2
      t.datetime :period_initial, :null => false
      t.datetime :period_final, :null => false

      t.timestamps
    end
    add_index :consolidates, :user_id
  end
end
