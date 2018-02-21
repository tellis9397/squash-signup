class AddDayOfPlayToBookings < ActiveRecord::Migration[5.0]
  def change
  	add_column :bookings, :day_of_play, :boolean, default: false
  end
end
