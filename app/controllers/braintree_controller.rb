class BraintreeController < ApplicationController
  def new
  	@client_token = Braintree::ClientToken.generate
  end

  def checkout
  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
  @reservation = Reservation.new(reservation_params)
  result = Braintree::Transaction.sale(
   :amount => @reservation.total_price, #this is currently hardcoded
   :payment_method_nonce => nonce_from_the_client,
   :options => {
      :submit_for_settlement => true
    }
   )

  	if result.success? 
      @reservation.save
      @customer = @reservation.user.full_name
      @host = @reservation.user.email
      @reservation_id = @reservation.id
      byebug
      ReservationJob.perform_now(@customer, @host, @reservation_id)
      # ReservationMailer.booking_email(@customer, @host, @reservation_id).deliver_now
    	redirect_to reservation_path(@reservation), :flash => { :success => "Booking and Transaction made successfully!" }
  	else 
    	redirect_to :root, :flash => { :error => "Transaction failed!" }
  	end
  end

  private

  def reservation_params
    params.permit(:user_id, :listing_id, :start_date, :end_date, :guest_no)
  end

end
