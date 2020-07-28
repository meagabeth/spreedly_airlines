class CreateFlights < ActiveRecord::Migration[6.0]
  def change
    create_table :flights do |t|
      t.integer :flight_number
      t.string :origin
      t.string :destination
      t.string :departure_time
      t.integer :price

      t.timestamps
    end
  end
end
