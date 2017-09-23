class ListingsController < ApplicationController
	def index
    if params[:tags]
      @listings = Listing.tagged_with(params[:tag])
    else
      @listings = Listing.all
      # Listing.order("title").paginate(:page => params[:page], :per_page => 30)
    end
  end

	def new
    	@listing = Listing.new
  	end

  	def create
	    @listing = current_user.listings.new(listing_params)
	    if @listing.save
	      @listings = Listing.all
	      redirect_to listings_path	
	    else
	      flash[:failure]= "Failed"
	      redirect_to new_listing_path
	    end
  	end

  	def edit
  		 @listing = Listing.find(params[:id])
  	end	

  	def update
  		@listing = Listing.find(params[:id])
      	if Listing.find_by(user_id: current_user.id)
      		if listing_params
      			@listing.update(listing_params)
      			flash[:success] = "Add Successfully"
        		redirect_to listings_path
    		else
      			@listing.update(verification: true)
      			redirect_to listings_path
    		end
    	end
    end

    def show
    	@listing = Listing.find(params[:id])
    end

     def destroy
      @listing = Listing.find(params[:id])
      if Listing.find_by(user_id: current_user.id) 
        @listing.destroy
        redirect_to root_path
      end
    end

  	def listing_params
  		if params[:listing]
    		params.require(:listing).permit(:title, :description, :property_type, :room_number, :bed_number, :guest_number, :address, :state, :postcode, :price, tag_list: [])
  		end
  	end

end

