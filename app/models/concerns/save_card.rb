module SaveCard
    extend ActiveSupport::Concern

    def save_card(transaction, spreedly_success)
        @new_card = Card.create(
            :email => transaction.email,
            :payment_method_token => transaction.payment_token,
            :last_four_digits => spreedly_success['transaction']['payment_method']['last_four_digits']
        )
    end
end