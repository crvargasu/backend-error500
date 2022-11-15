# frozen_string_literal: true

json.array! @api_v1_rental_agreements, partial: 'api_v1_rental_agreements/api_v1_rental_agreement',
                                       as: :api_v1_rental_agreement
