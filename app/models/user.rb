class User < ApplicationRecord
  include Clearance::User
  has_many :authentications, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :reservations
  enum role: { customer: 0, moderator: 1, superadmin: 2 }
  mount_uploader :photo, PhotoUploader
  validates :full_name, presence: true
  validates :email , uniqueness: true
  validates :password, presence: true, length: { in: 6..10 }

	def self.create_with_auth_and_hash(authentication, auth_hash)
      user = self.create!(
        full_name: auth_hash["extra"]["raw_info"]["name"],
        email: auth_hash["extra"]["raw_info"]["email"],
        password: SecureRandom.hex(10)
      )
      user.authentications << authentication
      return user
    end

    # grab fb_token to access Facebook for user data
    def fb_token
      x = self.authentications.find_by(provider: 'facebook')
      return x.token unless x.nil?
    end
end
