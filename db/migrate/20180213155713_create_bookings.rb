class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.string :date
      t.string :time

      t.timestamps
    end
  end
end
