class ListingsController < ApplicationController
	def index
		if params[:search]
			@index_title = "All search results for:"
			@search_term = "'#{params[:search]}'"

			@listings = Listing.search(params[:search]).order("created_at DESC").paginate(page: params[:page], per_page: 8)
		else
			@index_title = "My Listings"
			@listings = current_user.listings.all.paginate(page: params[:page], per_page: 8).order('created_at DESC')
		end
	end

	def show
		@listing = Listing.find(params[:id])
		@reservations = @listing.reservations
		@reservation = Reservation.new
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
		params.require(:listing).permit(:title, :address, :price, :max_num_guests, {photos: []}, :remove_photos)
	end
end
