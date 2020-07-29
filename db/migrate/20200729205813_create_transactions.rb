class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :email
      t.integer :flight_number
      t.integer :price
      t.string :payment_token
      t.boolean :retain_card
      t.boolean :expedia_purchase

      t.timestamps
    end
  end
end
