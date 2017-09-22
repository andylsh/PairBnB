class UsersController < Clearance::UsersController
	before_action :require_login, except:[:new, :create]

	def new
		@user= User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
	      redirect_to root_path
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
		if @user.update(user_params)
        	redirect_to edit_user_path
    	else
      		redirect_to edit_user_path
    	end
	end

	def show
    	@user = User.find(params[:id])
    	render "users/new"
    end

	def user_params
    	params.require(:user).permit(:full_name, :email, :password)
  	end
end
