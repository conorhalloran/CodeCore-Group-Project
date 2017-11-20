class AddEventIdToTeams < ActiveRecord::Migration[5.1]
  def change
    add_reference :teams, :event, foreign_key: true
  end
end
