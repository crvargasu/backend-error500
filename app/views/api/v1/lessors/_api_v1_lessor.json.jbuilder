# frozen_string_literal: true

json.extract! api_v1_lessor, :id, :title, :content, :created_at, :updated_at
json.url api_v1_lessor_url(api_v1_lessor, format: :json)
