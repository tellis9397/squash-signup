class AddRecurringOptionToBooking < ActiveRecord::Migration[5.0]
  def change
  	add_column :bookings, :recurring, :boolean, default: false
  end
end
