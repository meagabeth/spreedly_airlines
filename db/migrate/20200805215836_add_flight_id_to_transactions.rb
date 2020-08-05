class AddFlightIdToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :flight_id, :integer
  end
end
