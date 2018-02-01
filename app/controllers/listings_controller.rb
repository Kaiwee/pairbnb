class ListingsController < ApplicationController

	before_action :find_listing, only: [:show, :edit, :update]
	before_action :check_current_listing, only: [:edit, :update]

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
		@reservations = @listing.reservations
		@reservation = Reservation.new
	end

	def new
		@listing = Listing.new
	end

	def edit
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

	def find_listing
		if @listing = Listing.find_by(id: params[:id])
			return @listing
		else
			redirect_to '/', notice: "Listing does not exist"
		end	
	end

	def check_current_listing
		@user = User.find_by(id: @listing.user_id)
		if signed_in? and current_user.id != @user.id
			redirect_to "/", notice: "This is not your listing"
		elsif !signed_in?
			redirect_to "/", notice: "You need to log in first"
		end
	end

	def listing_params
		params.require(:listing).permit(:title, :address, :price, :max_num_guests, {photos: []}, :remove_photos)
	end
end
