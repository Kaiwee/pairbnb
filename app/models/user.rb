class User < ApplicationRecord
	include Clearance::User

	has_many :listings
	has_many :authentications, :dependent => :destroy
	has_many :reservations

	# User authorization
	enum status: { customer: 0, moderator: 1, superadmin: 2 }

	attr_accessor :image
	mount_uploader :image, ImageUploader

	def self.create_with_auth_and_hash(authentication,auth_hash)
		user = self.create! do |u|
			u.password = SecureRandom.hex(10)
			u.email = auth_hash["extra"]["raw_info"]["email"]
			u.name = auth_hash["extra"]["raw_info"]["name"]
		end
		user.authentications << authentication
		return user
	end

  # grab fb_token to access Facebook for user data
  def fb_token
  	x = self.authentications.where(:provider => :facebook).first
  	return x.token unless x.nil?
  end
end