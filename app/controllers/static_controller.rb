class StaticController < ApplicationController

	def index
		@listings = Listing.all.paginate(page: params[:page], per_page: 2).order('created_at DESC')
	end

	def about
	end
end