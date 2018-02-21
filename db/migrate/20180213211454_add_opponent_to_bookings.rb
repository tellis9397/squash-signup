class AddOpponentToBookings < ActiveRecord::Migration[5.0]
  def change
  	add_column :bookings, :opponent_first, :string
  	add_column :bookings, :opponent_last, :string
  end
end
