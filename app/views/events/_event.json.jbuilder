json.extract! event, :id, :type, :name, :location, :description, :user_id, :leader_id, :date, :start_time, :end_time, :created_at, :updated_at
json.url event_url(event, format: :json)
