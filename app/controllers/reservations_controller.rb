class ReservationsController < ApplicationController
	def index
	end

	def show
		@reservation = Reservation.find(params[:id])
	end

	def create
		# to find the listing_id bcoz the route to create is /listings/:listing_id/reservations
		@listing = Listing.find(params[:listing_id]) 
		@reservation = current_user.reservations.new(reservation_params)
		@customer = User.find(@reservation.user_id)
		@reservation.listing = @listing # not understand(to insert listing_id to database,but how?)
		if @reservation.save
			BookingEmailJob.perform_later(@reservation)
			HostEmailJob.perform_later(@customer, @host, @listing)
			redirect_to braintree_new_reservation_path(@reservation)
		else
			@errors = @reservation.errors.full_messages
			render "listings/show" 
		end
	end

	def destroy
		@reservation = Reservation.find(params[:id])
		@reservation.destroy
		redirect_to @reservation.listing
	end

	private
	def reservation_params
		params.require(:reservation).permit(:start_date, :end_date, :num_guests)
	end
end
