class UsersController < Clearance::UsersController
	before_action :require_login, except:[:new, :create, :edit]

	def new
		@user= User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
	      redirect_to listings_path
	    else
	      flash[:failure]= @user.errors.full_messages
	      redirect_to sign_up_path
	    end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		params[:user].delete(:password) if params[:user][:password].blank?
		if @user.id == current_user.id
			@user.update(user_params)
			flash[:success]= "Congratulation updated sucessfully"
        	redirect_to edit_user_path
    	else
    		flash[:failure]= "Failed to update"
      		redirect_to edit_user_path
    	end
	end

	def show
    	@user = User.find(pa 	rams[:id])
    	render "users/new"
    end

    def destroy
    	@user = User.find_by_id(params[:id])
	    if	@user.id == current_user.id
	    	@user.destroy
	    	flash[:success]= "Deleted successfully"
	    	redirect_to sign_in_path
    	else
 			flash[:failure]= "Failed to delete, Please try again later."
 			redirect_to edit_user_path
 		end
    end



	def user_params
    	params.require(:user).permit(:full_name, :email, :password, :photo)
  	end
end

