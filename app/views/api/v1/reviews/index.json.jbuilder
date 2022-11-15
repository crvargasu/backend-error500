# frozen_string_literal: true

json.array! @api_v1_reviews, partial: 'api_v1_reviews/api_v1_review', as: :api_v1_review
