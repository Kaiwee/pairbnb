class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validates :start_date, :end_date, :num_guests, presence: true
  validates :num_guests, numericality: { greater_than: 0 }

  validate :check_overlapping_dates
  validate :check_max_num_guests
  validate :valid_date # prevent reservation date before today

  def check_overlapping_dates
    # compare this new reservation againsts existing reservations
    if start_date.present? and end_date.present?
      listing.reservations.each do |old_reservation|
        if overlap?(self, old_reservation)
          return errors.add(:The_dates_are_not_available, "")
        end
      end
    end
  end

  def overlap?(x,y)
    (x.start_date - y.end_date) * (y.start_date - x.end_date) > 0
  end

  def check_max_num_guests
  	if num_guests.present?
  	 return if num_guests <= listing.max_num_guests
  	 errors.add(:Maximum_number_of_guests_is_exceeded, "")
  	end
  end

  def valid_date
  	if start_date.present? and end_date.present?
  		if start_date > DateTime.now and end_date > start_date
  			return 
  		else
  			errors.add(:Dates_are_invalid, "")
  		end
  	end
  end

  def total_price
    if start_date.present? and end_date.present?
    	price = listing.price
    	num_dates = ((start_date..end_date).to_a.length) - 1
    	return price * num_dates
    end	
  end

  def num_night
    if start_date.present? and end_date.present?
      num_dates = ((start_date..end_date).to_a.length) - 1
    end
  end

end
