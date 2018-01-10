class StaticController < ApplicationController

	def index
		@listings = Listing.all.paginate(page: params[:page], per_page: 5).order('created_at DESC')
	end

	def about
	end

	def contact_us
	end
end