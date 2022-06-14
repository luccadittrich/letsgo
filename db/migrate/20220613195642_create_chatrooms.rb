class CreateChatrooms < ActiveRecord::Migration[6.1]
  def change
    create_table :chatrooms do |t|
      t.references :followed, null: false, foreign_key: {to_table: :users}
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
