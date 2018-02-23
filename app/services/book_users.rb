class BookUsers
	def self.call(bookings, day_of)
		date = Date.today
		day_of_week_s = Date.today.strftime("%A")

		booked_courts = []
		remove_and_reset_bookings

		sleep_for = day_of ? 2.minutes : 0

		# user_pages = sign_in_users
		# to_book = reserve_court(user_pages)
		bookings.each do |booking|
			booked_courts << fill_booking(booking, sleep_for, day_of)
		end
		booked_courts
	end

	def self.fill_booking(booking, sleep_for, day_of)
		opponent_first_name = booking.opponent_first
		opponent_last_name = booking.opponent_last

		user_email = booking.user.email
		user_password = booking.user.brc_password

		day_of_week = booking.day_of_week
		date = Chronic.parse("this #{day_of_week}")

		booking_time = booking.time

		booking_date = date.strftime("%A %m/%d")

		begin
			mechanize = Mechanize.new
			mechanize.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE

			page = mechanize.get('http://www.xpiron.com/schedule/brc')

			form = page.forms.first

			form.pEmailAddr = "#{user_email}"
			form.pPassword = "#{user_password}"

			page = form.submit

			page = page.link_with(text: "HERE").click

			page = page.link_with(text: "SQUASH BOOKINGS").click

			page = day_of ? page : page.link_with(text: "#{booking_date}").click

			url_params = page.links_with(text: " #{booking_time}").first.attributes.attributes['href'].value.delete(",").split("'")
			url_params.shift; url_params.pop

			url_params.uniq!.delete("")

			url = "Booking?pAction=#{url_params[0]}&pTabServiceID=5926&pTimeSlotID=#{url_params[1]}&pBookingDate=#{url_params[2]}&pStartTime=#{url_params[3]}&pLocationID=#{url_params[4]}&pSpecID=#{url_params[5]}&pFunction=#{url_params[6]}"

			page = mechanize.get(url)
			sleep(sleep_for)

			form = page.forms.first

			form.pAction = "230"
			form.pFunction = "U"
			form.pBookeePosition = "2"
			page = form.submit
			sleep(sleep_for)

			form = page.forms.first

			form.pFirstName = "#{opponent_first_name}"
			form.pLastName = "#{opponent_last_name}"

			form.pAction = "350"
			page = form.submit
			sleep(sleep_for)

			form = page.forms.first
			form.pAction = "220"
			form.pFunction = "C"
			form.pBookingType = "L"
			form.pRecalculate = "Y"

			page = form.submit

			if page.title == nil
				booking.update_attributes(state: 'filled')
				return true
			else
				booking.update_attributes(state: 'failed')
				return false
			end
		rescue => e
			booking.update_attributes(state: 'failed')
			return false
		end
	end

	def self.remove_and_reset_bookings
		Booking.where(recurring: true).update_all(state: 'pending')
		Booking.where("state IN ('filled', 'failed')").destroy_all
	end
end

# In case it ever makes sense to ensure all courts can be taken.
# Pretty sure the xpiron site would have issues with scheduling blocks that vary in size when clicked into

# def self.sign_in_users
# 	user_page_hash

# 	User.all.each do |user|
# 		mechanize = Mechanize.new
# 		mechanize.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE

# 		page = mechanize.get('http://www.xpiron.com/schedule/brc')

# 		form = page.forms.first

# 		form.pEmailAddr = "#{user_email}"
# 		form.pPassword = "#{user_password}"

# 		page = form.submit
# 		page = page.link_with(text: "HERE").click
# 		page = page.link_with(text: "SQUASH BOOKINGS").click

# 		user_page_hash[user] = [mechanize, page]
# 	end
# end

# def self.reserve_court(user_page_hash)
# 	user_page_hash.each do |user, web_array|
# 		user.bookings.each do |booking|
# 			mechanize = web_array[0]
# 			page = web_array[1]

# 			day_of_week = booking.day_of_week
# 			date = Chronic.parse("this #{day_of_week}")

# 			booking_time = booking.time
# 			booking_date = date.strftime("%A %m/%d")

# 			page = page.link_with(text: "#{booking_date}").click
# 			url_params = page.links_with(text: " #{booking_time}").first.attributes.attributes['href'].value.delete(",").split("'")
# 			url_params.shift; url_params.pop

# 			url_params.uniq!.delete("")

# 			url = "Booking?pAction=#{url_params[0]}&pTabServiceID=5926&pTimeSlotID=#{url_params[1]}&pBookingDate=#{url_params[2]}&pStartTime=#{url_params[3]}&pLocationID=#{url_params[4]}&pSpecID=#{url_params[5]}&pFunction=#{url_params[6]}"

# 			page = mechanize.get(url)

# 			form = page.forms.first
# 		end
# 	end
# end