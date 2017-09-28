# require 'carrierwave/storage/fog'

# Cloudinary.config do |config|
#   config.cloud_name = ENV["cloud_name"]
#   config.api_key = ENV["api_key"]
#   config.api_secret = ENV["api_secret"]
#   config.cdn_subdomain = true
# end


# CarrierWave.configure do |config|
#   config.fog_credentials = {
#     :provider               => 'AWS',                             # required
#     :aws_access_key_id      => ENV['S3_KEY'],                     # ENV["api_secret"]required
#     :aws_secret_access_key  => ENV['S3_SECRET'],                  # required
#   }
#   config.fog_directory  = ENV['S3_BUCKET']                        # required
#   config.fog_public     = false                                   # optional, defaults to true
#   config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
# end

# CarrierWave.configure do |config|
#   config.fog_provider = 'fog/cloudinary'                        # required
#   config.fog_credentials = {
#     provider:              'AWS',                        # required
#     access_key_id:     ENV["api_key"],                        # required
#     aws_secret_access_key: ENV["api_secret"],                        # required
#   }
#   config.fog_directory  = ENV["cloud_name"]                          # required
#   config.fog_public     = false                                       # optional, defaults to true
#   config.fog_attributes = { cache_control: "public, max-age=#{365.day.to_i}" } # optional, defaults to {}
# end
