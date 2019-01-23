class UsersController < ApplicationController
	
	def index 
		@users = User.all
	end

	def create
		user = User.new(user_params)
		if user.save
			# flash[:message] = "HI!"
			redirect_to '/'
		else
			# flash[:message] = "Please try again."
			redirect_to '/sign_up'
		end
	end

	def edit

	end

	def destroy
	end

	private
		def user_params
			params.require(:user).permit(
			:first_name, 
			:last_name, 
			:email, 
			:gender, 
			:phone, 
			:country, 
			:birthdate, 
			:password,
			:avatar
		)
		end
end
		# require(come from users/_form model)
