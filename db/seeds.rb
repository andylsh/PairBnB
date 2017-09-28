# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = {}
user['password'] = 'password'


ActiveRecord::Base.transaction do
  20.times do 
    user['full_name'] = Faker::Name.name 
    user['email'] = Faker::Internet.email
    
    User.create(user)
  end
end  

# Seed Listings
listing = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  40.times do 
    listing['title'] = Faker::App.name
    listing['description'] = Faker::Hipster.sentence
    listing['property_type'] = ["HOUSE", "ENTIRE FLOOR", "CONDOMINIUM", "VILLA", "TOWNHOUSE", "CASTLE", "TREEHOUSE", "Hut", "Other"].sample

    listing['room_number'] = rand(1..5)
    listing['bed_number'] = rand(1..6)
    listing['guest_number'] = rand(1..10)

    listing['address'] = Faker::Address.street_address
    listing['state'] = ["JOHOR", "KEDAH", "KELANTAN", "KL", "MELAKA", "N.SEMBILAN", "P.PENANG", "PAHANG", "PERAK", "PERLIS", "SABAH", "SARAWAK", "SELANGOR", "TERENGGANU"].sample
    listing['postcode'] = Faker::Address.zip_code
    listing['tag_list'] = ["Smoker", "Non-smoker", "Pets", "Cooking allowed"].sample
    

    listing['price'] = rand(80..500)
   

    listing['user_id'] = uids.sample

    Listing.create(listing)
  end
end
