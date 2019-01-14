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
			redirect_to listings_path
		else
			flash[:message] = "Try again."
			redirect_to listings_path
		end
	end

	def show
		@listing = Listing.find(params[:id])
		@user = User.find(@listing.user_id)
	end

	def edit
		@lisintg = Listing.find(params[:id])
	end

	def update
	end

	def destroy
		@listing = Listing.find(params[:id]).delete
		redirect_to listings_path
	end

	def verify
		listing = Listing.find(params[:id])

		if listing.verified?
			listing.update(verified: false)
			flash[:message] = "It has been unverified."
		else
			# listing.verify = 'true'
			listing.update(verified: true)
			flash[:message] = "It has been verified."
		end
			redirect_to listing_path
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
