class ListingsController < ApplicationController
	def index
		@listings = current_user.listings.all.paginate(page: params[:page], per_page: 5).order('created_at DESC')
	end

	def show
		@listing = Listing.find(params[:id])
		@reservation = @listing.reservations.new
		@reservations = @listing.reservations
	end

	def new
		@listing = Listing.new
	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def create
		@listing = current_user.listings.new(listing_params)
		if @listing.save
			redirect_to @listing
		else
			render "new"
		end
	end

	def update
		@listing = Listing.find(params[:id])
		@listing.update(listing_params)
		@listing.Verified! if current_user.moderator?
		redirect_to @listing
	end

	def destroy
		@listing = Listing.find(params[:id])
		@listing.destroy
		redirect_to listings_path
	end

	private
	def listing_params
		params.require(:listing).permit(:title, :address, :price, :max_num_guests, {photos: []})
	end
end
