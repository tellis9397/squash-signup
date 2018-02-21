class AddBrcPasswordToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :brc_password, :string
  end
end
