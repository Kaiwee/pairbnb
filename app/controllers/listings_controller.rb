class ListingsController < ApplicationController
	def index
		@listings = Listing.all
	end

	def show
		@listing = Listing.find(params[:id])
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

	def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to listings_path
end

	private
	def listing_params
		params.require(:listing).permit(:title, :address, :price)
	end
end
