class Transaction < ApplicationRecord
    belongs_to :flight

    # valid? method called in controller will review the following:
    validates :payment_token, presence: true
    validates :price, presence: true

end
