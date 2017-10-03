class ListingsController < ApplicationController
  before_action :require_login

  # def index
  #   if params[:tags]
  #     @listings = Listing.tagged_with(params[:tag])
  #  elsif params[:search]
  #     @listings = Listing.search(params[:search]).page(params[:page]).per_page(6)
  #   else
  #      @listings = Listing.order("title").paginate(:page => params[:page], :per_page => 30)
  #   end
  # end
	
    # def index
    #     if current_user.superadmin?
    #       if params[:tag]
    #         @listings = Listing.tagged_with(params[:tag]).page(params[:page]).per_page(6) 
    #       elsif params[:search].nil?
    #         @listings = Listing.order("created_at DESC").page(params[:page]).per_page(6)
    #       else
    #         @listings = Listing.search(params[:search]).page(params[:page]).per_page(6)
    #       end
    #     elsif current_user.moderator?
    #       if params[:tag]
    #         @listings = Listing.tagged_with(params[:tag]).page(params[:page]).per_page(6).where(verification: false)
    #       elsif params[:search].nil?
    #         @listings = Listing.order("created_at DESC").page(params[:page]).per_page(6).where(verification: false)
    #       else
    #         @listings = Listing.search(params[:search]).page(params[:page]).per_page(6).where(verification: false)
    #       end
    #       elsif
    #         if params[:tag]
    #           @listings = Listing.tagged_with(params[:tag]).page(params[:page]).per_page(6).where(verification: true)
    #         elsif params[:search].nil?
    #           @listings = Listing.order("created_at DESC").page(params[:page]).per_page(6).where(verification: true)
    #         else
    #           @listings =  Listing.search(params[:search]).page(params[:page]).per_page(6).where(verification: true)
    #         end
    #     end
    # end

    # def index
    #   @listings = Listing.all.order("created_at DESC").page(params[:page]).per_page(6).check_role(current_user)
    #   @listings = Listing.tagged_with(params[:tag]).page(params[:page]).per_page(6).check_role(current_user) if params[:tag]
    #   # @listings = Listing.search(params[:search]).page(params[:page]).per_page(6) if params[:search].present?
    #   # @listings = Listing.price(params[:price]).page(params[:page]).per_page(6) if params[:price].present?
    #     filtering_params(params).each do |key, value|
    #         # unless key == "price" && value < 100
    #         if key == "price" and value.to_i <= 100
    #           value = nil
    #         end
    #           @listings = @listings.order("created_at DESC").public_send(key, value) if value.present?
    #         # end
    #    end
    # end

    def index
       if params[:tag]
      @listings = Listing.tagged_with(params[:tag]).page(params[:page]).per_page(6).check_role(current_user)
      # @listings = Listing.search(params[:search]).page(params[:page]).per_page(6) if params[:search].present?
      # @listings = Listing.price(params[:price]).page(params[:page]).per_page(6) if params[:price].present?
            # unless key == "price" && value < 100
      else
       @listings = Listing.filter(params.slice(:state, :price)).page(params[:page]).per_page(6).check_role(current_user)
       end
    end

    def new
        @listing = Listing.new
    end

    def create
        @listing = current_user.listings.new(listing_params)
        if @listing.save
          @listings = Listing.order("created_at DESC").page(params[:page]).per_page(6)
          redirect_to listings_path, notice: "Successfuly created" 
        else
          redirect_to new_listing_path, notice: "Failed to add listings"
        end
    end


  	def edit
  		 @listing = Listing.find(params[:id])
  	end	

  	def update
  		@listing = Listing.find(params[:id])
      	if listing_params
          if Listing.find_by(user_id: current_user.id) == current_user.id || current_user.superadmin?
      			@listing.update(listing_params)
        		redirect_to listings_path, notice: "Listings is updated successfully"
          else
            flash[:failure]= "You don't have the authorization to edit"
            redirect_to listings_path
          end
    		else
          if current_user.superadmin? || current_user.moderator?
      			@listing.update(verification: true)
      			redirect_to listings_path, notice: "Verified successfully"
    		 end
    	 end
    end

    def show
    	 @listing = Listing.find(params[:id])
    end

     def destroy
      @listing = Listing.find(params[:id]) 
      if Listing.find_by(user_id: current_user.id) == current_user.id || current_user.superadmin?
        @listing.destroy
        redirect_to listings_path, notice: "Deleted the listings successfully"
      end
    end
    
    private

  	def listing_params
  		if params[:listing]
    		params.require(:listing).permit(:title, :description, :property_type, :room_number, :bed_number, :guest_number, :address, :state, :postcode, :price, tag_list: [], images: [])
  		end
  	end

   #  def filtering_params(params)
   #   params.slice(:price, :state)
   # end
 end