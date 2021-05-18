# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'json'
require "open-uri"

number = 1
sizes = ['XS', 'S', 'M', 'L', 'XL']
conditions = ['New', 'Used']
products = ["Levis 522, Patent Black","Pattern Jeans, Blue","Leather Driver Jacket","Gold Button Cardigan, Black","Fine Stripe Shirt","Lightweight Pocket￼Blazer"]

url = 'https://randomuser.me/api/?results=10'
users_serialized = URI.open(url).read
users = JSON.parse(users_serialized)

puts 'Cleaning DB'
Purchase.destroy_all
Review.destroy_all
User.destroy_all
Listing.destroy_all
puts 'DB is clean'
puts "creating users & listings"

users['results'].each do |user|
  # puts user
  file = URI.open(user["picture"]["large"])
  file_listing = URI.open("https://source.unsplash.com/random?clothes,trendy")
  user_new = User.new({
    email: user["email"],
    password: Faker::Internet.password(min_length: 7),
    first_name:user["name"]["first"],
    last_name:user["name"]["last"],
    address:[user["location"]["street"]["number"],user["location"]["street"]["name"],user["location"]["city"]].join(" "),
    country:user["location"]["country"]
  })
  user_new.photo.attach(io: file, filename: 'user_pic.png', content_type: 'image/png')
  user_new.save!
  new_listing = Listing.new({
                  listing_name:products[rand(0..5)],
                  price: rand(19.99..199.99),
                  size: sizes[rand(0..4)],
                  condition: conditions[rand(0..1)],
                  description: Faker::Quotes::Shakespeare.as_you_like_it_quote,
                  user_id: user_new.id
                })
  new_listing.photos.attach(io: file_listing, filename: 'randomlisting.png', content_type: 'image/png')
  new_listing.save!
  puts "#{user_new.first_name} has been created"
end





# 10.times do
#   file = URI.open('https://picsum.photos/200/300')
#   file_listing = URI.open('https://source.unsplash.com/random')
#   user_new = User.new({
#     email: Faker::Internet.email,
#     password: Faker::Internet.password(min_length: 7),
#     first_name:Faker::Name.first_name,
#     last_name:Faker::Name.last_name,
#     address:Faker::Address.full_address,
#     country:Faker::Address.country_code
#   })
#   user_new.photo.attach(io: file, filename: 'random.png', content_type: 'image/png')
#   user_new.save!
#   new_listing = Listing.new({
#                   listing_name:Faker::Team.name,
#                   price: rand(19.99..199.99),
#                   size: sizes[rand(0..4)],
#                   condition: conditions[rand(0..1)],
#                   description: Faker::Quotes::Shakespeare.as_you_like_it_quote,
#                   user_id: user_new.id
#                 })
#   new_listing.photos.attach(io: file_listing, filename: 'random.png', content_type: 'image/png')
#   new_listing.save!
#   puts "#{user_new.first_name} has been created"
# end
