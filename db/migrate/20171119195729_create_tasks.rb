class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name, null: false, default: ""
      t.text :description
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.string :status
      t.date :due_by
      t.bigint :assigned_by 

      t.timestamps null: false
    end
  end
end
