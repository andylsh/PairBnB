class ReservationsController < ApplicationController
	def new
		@reservation = Reservation.new
		@listing = Listing.find(params[:listing_id])	  
	end

	def create
       @listing = Listing.find(params[:listing_id])
       @reservation = current_user.reservations.new(reservation_params)
       @reservation.listing = @listing
       if @reservation.save
       		redirect_to reservation_path(@reservation), notice: "Book successfully"
       	else
       		redirect_to new_listing_reservation_path
       		flash[:notice] = @reservation.errors.full_messages
       	end

    end

    def show
    	@reservation = Reservation.find(params[:id])		
    end

    private
    def reservation_params
    	params.require(:reservation).permit(:start_date, :end_date, :guest_no )
    end
end

