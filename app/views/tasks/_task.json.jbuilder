json.extract! task, :id, :name, :description :user_id, :event_id, :status, :due_by, :assigned_by, :created_at, :updated_at
json.url task_url(task, format: :json)
