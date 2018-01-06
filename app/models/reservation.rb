class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validates :start_date, :end_date, :num_guests, presence: true
end
