class CreateMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :memberships do |t|
      t.belongs_to :user, index: true
      t.belongs_to :team, index: true
      t.boolean :is_leader, default: false
      t.timestamps
    end
  end
end
