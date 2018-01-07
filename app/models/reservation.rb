class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validates :start_date, :end_date, :num_guests, presence: true
  validates :num_guests, numericality: { greater_than: 0 }

  validate :check_overlapping_dates
  validate :check_max_num_guests

  def check_overlapping_dates
  end

  def check_max_num_guests
  	return if num_guests <= listing.max_num_guests
  	errors.add(:Maximum_number_of_guests_is_exceeded, "")
  end
end
