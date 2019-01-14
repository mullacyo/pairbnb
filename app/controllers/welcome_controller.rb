class WelcomeController < ApplicationController
	def index
		if signed_in?
			@name = "#{current_user.first_name} #{current_user.last_name}"
			@role = "#{current_user.role}"
		else
			@name = "Guest"
		end
	end
end