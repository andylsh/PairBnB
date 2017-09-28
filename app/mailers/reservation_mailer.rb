class ReservationMailer < ApplicationMailer

	def booking_email(customer, host, reservation_id)
		@customer = customer
		@host = host
		@reservation_id = reservation_id
		byebug
		mail(to: @host, subject: "Congratulation... Enjoy your holiday...")
  	end
end