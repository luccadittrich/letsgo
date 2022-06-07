class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.date :date
      t.string :name
      t.string :local
      t.string :description
      t.string :category
      t.boolean :private, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
