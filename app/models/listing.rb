class Listing < ApplicationRecord
	belongs_to :user

	validates :title, :address, :price, presence: true
	validates :price, numericality: { greater_than: 0 }

	enum status: { customer: 0, moderator: 1, superadmin: 2 }
end
