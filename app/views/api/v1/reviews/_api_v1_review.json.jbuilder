json.extract! api_v1_review, :id, :title, :content, :created_at, :updated_at
json.url api_v1_review_url(api_v1_review, format: :json)
