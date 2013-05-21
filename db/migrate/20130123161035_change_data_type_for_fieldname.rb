class ChangeDataTypeForFieldname < ActiveRecord::Migration
  def up
    change_table :extract_monthlies do |t|
      t.change :code_beneficiary, :string, :null => false
    end
  end

  def down
    change_table :extract_monthlies do |t|
      t.change :code_beneficiary, :integer, :null => false
    end
  end
end
