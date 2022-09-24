json.extract! rental_agreement, :id, :timestamp_start, :timestamp_end, :status, :created_at, :updated_at
json.url rental_agreement_url(rental_agreement, format: :json)
