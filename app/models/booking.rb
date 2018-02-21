class Booking < ActiveRecord::Base

	belongs_to :user, inverse_of: :bookings

	validates :user_id,        presence: true
	validates :day_of_week,    presence: true
	validates :time,           presence: true
	validates :opponent_first, presence: true
	validates :opponent_last,  presence: true

	validate :no_recurring_day_of_play

	validates_format_of :opponent_first, :opponent_last, :with => /\A[a-z]+\z/i

	def booking_times
		%w(6:30am 7:15am 8:00am 9:00am 9:45am 10:30am 11:30am 12:15pm 1:00pm 1:45pm 2:30pm 3:15pm 4:15pm 5:00pm 5:45pm 6:30pm 7:15pm)
	end

	def booking_days
		%w(Monday Tuesday Wednesday Thursday Friday)
	end

	def opponent_s
		"#{opponent_first.capitalize} #{opponent_last.capitalize}"
	end

	def filled?
		state == 'filled'
	end

	def type
		if recurring
			"Recurring"
		elsif day_of_play
			"Day of Play"
		else
			"One-time"
		end
	end

	private

		def no_recurring_day_of_play
			if recurring && day_of_play
				errors.add(:base, "No recurring day of play courts")
			end
		end
end
