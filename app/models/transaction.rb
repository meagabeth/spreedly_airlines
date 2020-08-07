require "httparty"

class Transaction < ApplicationRecord
    belongs_to :flight
    include HTTParty

    # valid? method called in controller will review the following:
    validates :payment_token, presence: true
    validates :price, presence: true
    validates :email, presence: true

    def spreedly_purchase(token, amount)
        spreedly_url = 'https://core.spreedly.com/v1/gateways/'
        purchase_url = spreedly_url + ENV['gateway_token'] + '/purchase.json'

        options = {
            headers: {'Content-Type' => 'application/json'},
            basic_auth: {
                "username": ENV['environment_key'],
                "password": ENV['access_secret']
            },
            body: {
                "transaction": {
                    "payment_method_token": token,
                    "amount": amount,
                    "currency_code": "USD",
                    "retain_on_success": true
                }
            }.to_json
        }

        response = HTTParty.post(purchase_url, options)
        puts response
        response
    end

    def expedia_pmd(transaction)
        expedia_url = 'https://core.spreedly.com/v1/receivers/'
        exp_purchase_url = expedia_url + 'aJCpwfnsEcwbe6acyuntpuF72JZ' + '/deliver.json'

        options = {
            headers: {'Content-Type' => 'application/json'},
            basic_auth: {
                "username": ENV['environment_key'],
                "password": ENV['access_secret']
            },
            body: {
                "delivery": {
                    "payment_method_token": transaction.payment_token,
                    "url": "https://spreedly-echo.herokuapp.com",
                    "headers": "Content-Type: application/json",
                    "body": {
                        "flight_id": transaction.flight_id,
                        "price": transaction.price,
                        "email": transaction.email,
                        "card_number":"{{ credit_card_number}}"
                    }
                }
            }.to_json
        }

        response = HTTParty.post(exp_purchase_url, options)
        puts response
        response
    end

end
