class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.integer :status, null: false

      t.references :book, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
