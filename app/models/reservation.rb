class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validates :start_date, :end_date, :num_guests, presence: true
  validates :num_guests, numericality: { greater_than: 0 }

  validate :check_overlapping_dates
  validate :check_max_num_guests
  validate :valid_date # prevent reservation date before today

  def check_overlapping_dates
  end

  def check_max_num_guests
  	return if num_guests <= listing.max_num_guests
  	errors.add(:Maximum_number_of_guests_is_exceeded, "")
  end

  def valid_date
  	if start_date > DateTime.now and end_date > start_date
  		return 
  	else
  		errors.add(:Dates_are_invalid, "")
  	end
  end
end
