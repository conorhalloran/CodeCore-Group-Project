class ChangeStartTimeFormat < ActiveRecord::Migration[5.1]
  def change
    change_column :events, :start_time, :string
  end
end
