class AddAddressComplementToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :address_complement, :string
  end
end
