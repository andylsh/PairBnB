class Listing < ApplicationRecord
	belongs_to :user
	has_many :reservations
	acts_as_taggable # Alias for acts_as_taggable_on :tags
	serialize :images, Array
	mount_uploaders :images, ImageUploader
	validates :title, presence: true
	validates :description, presence: true
	validates :room_number, presence: true, numericality: { only_integer: true, greater_than: 0, message: "Must be a positive value" }
	validates :bed_number, presence: true, numericality: { only_integer: true, greater_than: 0, message: "Must be a positive value" }
	validates :guest_number, presence: true, numericality: { only_integer: true, greater_than: 0, message: "Must be a positive value" }
	validates :address, presence: true
	validates :state, presence: true
	validates :postcode, presence: true, numericality: { only_integer: true}, length: { is: 5 }
	validates :price, presence: true, numericality: {greater_than: 0, message: "Must be a positive value"}
	scope :price, -> (price) {where("price < ?", price)}
	scope :state, -> (state) {where state: state}
	
	# def self.search(search)
	# 	if search.present?
	# 		@listing = Listing.where(["state LIKE ?", "%#{search}%"])
	# 	else
	# 		@listing = Listing.all
	# 	end
	# end


	def self.check_role(user)
		if user.superadmin?
			Listing.all
		elsif user.moderator?
			Listing.where(:verification => false)
		else 
			Listing.where(:verification => true)
		end
	end

	def self.filter(filtering_params)
	  results= self.where(nil)
      filtering_params.each do |key, value|
      	if key == "price" and value.to_i <= 100
              value = nil
        end
        results = results.order("created_at DESC").public_send(key, value) if value.present?
      end
      results
    end

end