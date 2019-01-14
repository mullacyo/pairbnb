class ListingsController < ApplicationController
	def index
		@listings = Listing.page(params[:page])
	end

	def new
		@listing = Listing.new
	end

	def create
		listing = Listing.new(listing_params)
		listing.user_id = current_user.id
		if listing.save
			flash[:message] = "Saved!"
			redirect_to root_path
		else
			flash[:message] = "Try again."
			redirect_to root_path
		end
	end

	def show
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private
	def listing_params
		params.require(:listing).permit(
			:name,
			:description,
			:place_type,
			:property_type,
			:room_number,
			:bed_number,
			:guest_number,
			:address,
			:city,
			:state,
			:country,
			:zipcode,
			:price
			)
	end
end
