class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :show]
	before_action :require_same_user, only: [:edit, :update]
	def index
		@users = User.paginate(page: params[:page], per_page: 5)
	end
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id 
			redirect_to user_path(@user), flash: {success: "Welcome to Writer's Delight #{@user.username}" }
		else
			render 'new'	
		end
	end
	def edit
		
	end
    def update
    	
		if @user.update(user_params)
			redirect_to articles_path, flash:{success: "Your account was updated successfully"}
		else
			render 'edit'
		end
	end
	def show
		
	end



	private
	def set_user
		@user = User.find(params[:id])
	end
	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	def require_same_user
		 redirect_to root_path, flash: {danger: "You can only edit your own account" } if current_user != @user
	end

end