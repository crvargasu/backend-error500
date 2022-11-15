# frozen_string_literal: true

json.extract! api_v1_leaseholder, :id, :title, :content, :created_at, :updated_at
json.url api_v1_leaseholder_url(api_v1_leaseholder, format: :json)
