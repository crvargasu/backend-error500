# frozen_string_literal: true

json.extract! api_v1_rental_agreement, :id, :title, :content, :created_at, :updated_at
json.url api_v1_rental_agreement_url(api_v1_rental_agreement, format: :json)
