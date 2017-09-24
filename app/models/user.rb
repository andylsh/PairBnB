class User < ApplicationRecord
  include Clearance::User
  has_many :listings, dependent: :destroy
  enum role: { customer: 0, moderator: 1, superadmin: 2 }
  mount_uploader :photo, PhotoUploader

end
