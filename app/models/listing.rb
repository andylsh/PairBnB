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

	def self.search(search)
		if search.present?
			@listing = Listing.where(["state LIKE ?", "%#{search}%"])
		else
			@listing = Listing.all
		end
	end

end
