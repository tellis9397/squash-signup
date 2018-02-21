class RenameBookingColumnToDayOfWeek < ActiveRecord::Migration[5.0]
  def change
  	rename_column :bookings, :date, :day_of_week
  end
end
