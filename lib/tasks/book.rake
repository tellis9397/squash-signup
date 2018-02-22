namespace :book do
	task :book_normal_courts => :environment do
		BookUsers.call(Booking.where(day_of_play: false).where(state: 'pending'), false)
	end

	task :book_day_of_play_courts => :environment do
		sleep(25.minutes)
		BookUsers.call(Booking.where(day_of_play: true)
			.where(state: 'pending')
			.where(day_of_week: Date.today.strftime("%A")), true)
	end
end