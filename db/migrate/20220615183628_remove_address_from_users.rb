class RemoveAddressFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :address, :string
  end
end
