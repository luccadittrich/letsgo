class AddViewedToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :viewed, :boolean, default: false
  end
end
