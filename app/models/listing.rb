class Listing < ApplicationRecord
	belongs_to :user
	acts_as_taggable # Alias for acts_as_taggable_on :tags

	def self.search(search)
		if search.present?
			@listing = Listing.where(["state LIKE ?", "%#{search}%"])
		else
			@listing = Listing.all
		end
	end

end
