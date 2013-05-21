class AddCpfCnpjToUser < ActiveRecord::Migration
  def change
    add_column :users, :cpf_cnpj, :integer
  end
end
