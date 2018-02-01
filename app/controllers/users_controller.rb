class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update]
	before_action :check_current_user, only: [:edit, :update]
	
	def show
		@reservations = @user.reservations
	end

	def edit
		@user = current_user
	end

	def update
		@user.update(user_params)
		redirect_to @user
	end 

	private

	def set_user
		if @user = User.find_by(id: params[:id])
			return @user
		else
			redirect_to '/', notice: "User does not exist"
		end	
	end

	def check_current_user
		if signed_in? and current_user.id != @user.id
			redirect_to "/", notice: "This is not your profile"
		elsif !signed_in?
			redirect_to "/", notice: "You need to log in first"
		end	
	end

	def user_params
		params.require(:user).permit(:email, :password, :image, :remove_image)
	end
end