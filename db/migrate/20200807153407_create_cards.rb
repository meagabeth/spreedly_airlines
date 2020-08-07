class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :email
      t.string :payment_method_token
      t.string :last_four_digits

      t.timestamps
    end
  end
end
