class BookingsController < ApplicationController
    def index
    end

    def new
        @listing = Listing.find(params[:listing_id])
        @booking = Booking.new
        @guest_number = @listing.guest_number
    end
    
    def create
        @listing = Listing.find(params[:listing_id])
        @guest = current_user
        @guest_number = @listing.guest_number
        booking = Booking.new(booking_params)
        booking.user_id = current_user.id
        if booking.save
            flash[:message] = "Saved!"
			ReservationJob.perform_later(current_user,@listing.user_id,@listing)
			redirect_to new_listing_payment_path
		else
			flash[:message] = "Try again."
			redirect_to booking_path
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
    def booking_params
        params.require(:booking).permit(
            :listing_id,
            :guest_number,
            :checkin_date,
            :checkout_date,
            :request
        )
    end
    
end
