# frozen_string_literal: true

json.extract! api_v1_admin, :id, :title, :content, :created_at, :updated_at
json.url api_v1_admin_url(api_v1_admin, format: :json)
