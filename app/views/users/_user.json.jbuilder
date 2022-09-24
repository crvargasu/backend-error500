json.extract! user, :id, :name, :picture, :phone, :email, :street, :city, :created_at, :updated_at
json.url user_url(user, format: :json)
