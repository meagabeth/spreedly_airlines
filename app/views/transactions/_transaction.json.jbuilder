json.extract! transaction, :id, :email, :flight_number, :price, :payment_token, :retain_card, :expedia_purchase, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
