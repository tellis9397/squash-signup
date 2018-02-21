json.extract! user_show, :id, :title, :created_at, :updated_at
json.url user_show_url(user_show, format: :json)
