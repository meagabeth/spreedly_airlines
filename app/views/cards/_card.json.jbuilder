json.extract! card, :id, :email, :payment_method_token, :last_four_digits, :created_at, :updated_at
json.url card_url(card, format: :json)
