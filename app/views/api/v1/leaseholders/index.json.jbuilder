# frozen_string_literal: true

json.array! @api_v1_leaseholders, partial: 'api_v1_leaseholders/api_v1_leaseholder', as: :api_v1_leaseholder
