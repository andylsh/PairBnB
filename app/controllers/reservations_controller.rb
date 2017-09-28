class ReservationsController < ApplicationController
	def new
		@reservation = Reservation.new
		@listing = Listing.find(params[:listing_id])	  
	end

	def create
       @listing = Listing.find(params[:listing_id])
       @reservation = current_user.reservations.new(reservation_params)
       @reservation.listing = @listing
       if @reservation.valid?
          redirect_to braintree_new_path(user_id: current_user.id, listing_id: @reservation.listing_id, start_date: @reservation.start_date, end_date: @reservation.end_date, guest_no: @reservation.guest_no)
       else
       # if @reservation.save
       # 		redirect_to reservation_braintree_new_path(@reservation), notice: "Book successfully"
       # 	else
       		redirect_to new_listing_reservation_path
       		flash[:notice] = @reservation.errors.full_messages
        end
    end

    def index
      if current_user.superadmin? || current_user.moderator?
        @reservations = Reservation.all
      elsif current_user.customer?
        @reservations = Reservation.where(user_id: current_user.id)
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

 