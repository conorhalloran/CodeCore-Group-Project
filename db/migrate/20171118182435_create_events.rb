class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.text :type
      t.string :name
      t.string :location
      t.text :description
      t.references :user, foreign_key: true
      t.date :date
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
