class AddFollowerToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_reference :notifications, :follower, null: false, foreign_key: { to_table: :follows }
  end
end
