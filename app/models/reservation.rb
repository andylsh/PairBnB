class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :guest_no, presence: true, numericality: { only_integer: true}
  validate :check_overlapping_dates
  validate :check_max_guests
  validate :check_owner

  def check_overlapping_dates
  	listing.reservations.each do |old_booking|
  		if overlap?(self, old_booking)
  			return errors.add(:overlapping_dates, "The booking dates had been reserved")
      end
  	end
  end

  def overlap?(x,y) 
      (x.start_date - y.end_date) * (y.start_date-x.end_date ) > 0 || (x.start_date == y.end_date)
  end

  def check_max_guests
  	if guest_no > listing.guest_number || guest_no < 1
  		return errors.add(:max_guests, "Exceeding number of guests") 
  	end
  end

  def check_owner
    if listing.user.id == self.user_id
      return errors.add(:wrong_user, "You cannot book your own property")
    end
  end

  def total_price
    price = listing.price
    num_dates = (start_date..end_date).to_a.length - 1
    return price * num_dates
  end 

  
end