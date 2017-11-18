class ChangeEndTimeFormat < ActiveRecord::Migration[5.1]
  def change
    change_column :events, :end_time, :string
  end
end
