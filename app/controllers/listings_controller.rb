class ListingsController < ApplicationController
	def index
		@listings = Listing.page(params[:page])
		@listings = @listings.listing_name(params[:listing_name].strip).page(params[:page]).order('created_at DESC') if params[:listing_name].present?
		@listings = @listings.descrip(params[:description].strip).page(params[:page]).order('created_at DESC') if params[:description].present?
	
		if params[:min_price].present? && params[:max_price].present?
			@listings = @listings.price(params[:min_price], params[:max_price]).page(params[:page]).order('created_at DESC') 
		elsif params[:min_price].present?
			@listings = @listings.where("price > #{params[:min_price]}").page(params[:page]).order('created_at DESC')
		elsif params[:max_price].present?
			@listings = @listings.where("price < #{params[:max_price]}").page(params[:page]).order('created_at DESC')    
		elsif params[:tag]
		  @listings = Listing.tagged_with(params[:tag].titleize).paginate(:page => params[:page])
		end

	end

	def new
		@listing = Listing.new
	end

	def create
		listing = Listing.new(listing_params)
		listing.user_id = current_user.id
		if listing.save
			flash[:message] = "Saved!"
			@listing = Listing.find(params[:listing_id])
			ReservationMailer.booking_email(current_user,listing.user_id,listing).deliver_now
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

	def search
		@name = Listing.search_city(params["query"])
		@listings = Listing.all
		# byebug
		respond_to do |format|
		  format.json { render json: @listings }
		  format.js # remote: true is sent a js format and sends you to search.js.erb
		end
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
