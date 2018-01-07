class Listing < ApplicationRecord
	belongs_to :user
	has_many :reservations

	validates :title, :address, :price, presence: true
	validates :price, :max_num_guests, numericality: { greater_than: 0 }

	# User authorization
	enum status: { Unverified: 0, Verified: 1}

	mount_uploaders :photos, PhotosUploader
end
