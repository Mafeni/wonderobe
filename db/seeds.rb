# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require "open-uri"

number = 1
sizes = ['XS', 'S', 'M', 'L', 'XL']
conditions = ['New', 'Used']

puts 'Cleaning DB'
User.destroy_all
Listing.destroy_all
puts 'DB is clean'

puts "creating users & listings"

# new_listing = Listing.new({
#                   listing_name:Faker::Team.name,
#                   price: rand(19.99..199.99),
#                   size: sizes[rand(0..4)],
#                   condition: conditions[rand(0..1)],
#                   description: Faker::Quotes::Shakespeare.as_you_like_it_quote,
#                   user_id: rand(1..10),
#                   photos: ["http://res.cloudinary.com/dh5s1kdcd/image/upload/v1620759459/bav7vyqynwpkfbatxxsp.jpg","http://res.cloudinary.com/dh5s1kdcd/image/upload/v1620758619/nnxzwdci8atqyrep3rw8.jpg"]
#                 })
# new_listing.save


10.times do
  file = URI.open('https://picsum.photos/200/300')
  file_listing = URI.open('https://source.unsplash.com/random')
  user_new = User.new({
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 7),
    first_name:Faker::Name.first_name,
    last_name:Faker::Name.last_name,
    address:Faker::Address.full_address,
    country:Faker::Address.country_code
  })
  user_new.photo.attach(io: file, filename: 'random.png', content_type: 'image/png')
  user_new.save!
  new_listing = Listing.new({
                  listing_name:Faker::Team.name,
                  price: rand(19.99..199.99),
                  size: sizes[rand(0..4)],
                  condition: conditions[rand(0..1)],
                  description: Faker::Quotes::Shakespeare.as_you_like_it_quote,
                  user_id: user_new.id
                })
  new_listing.photos.attach(io: file_listing, filename: 'random.png', content_type: 'image/png')
  new_listing.save!
  puts "#{user_new.first_name} has been created"
end
