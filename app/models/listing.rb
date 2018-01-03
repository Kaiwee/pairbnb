class Listing < ApplicationRecord
	belongs_to :user

	validates :title, :address, :price, presence: true
	validates :price, numericality: { greater_than: 0 }
end
