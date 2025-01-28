# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


require 'faker'

puts "Creating 100 dummy products..."

CATEGORIES = ['Electronics', 'Clothing', 'Books', 'Mobiles', 'Sports' ,'Accessories']
SAMPLE_IMAGES = [
  'https://picsum.photos/seed/electronics1/800/600',
  'https://picsum.photos/seed/laptop/800/600',
  'https://picsum.photos/seed/phone/800/600',
  'https://picsum.photos/seed/headphones/800/600',
  'https://picsum.photos/seed/camera/800/600',
  'https://picsum.photos/seed/fashion1/800/600',
  'https://picsum.photos/seed/clothing/800/600',
  'https://picsum.photos/seed/shoes/800/600',
  'https://picsum.photos/seed/accessories/800/600',
  'https://picsum.photos/seed/watch/800/600',]

  user_ids = User.pluck(:id)

100.times do |i|
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    price: Faker::Commerce.price(range: 10..1000.0),
    category: CATEGORIES.sample,
    user_id: user_ids.sample, 
    image: SAMPLE_IMAGES.sample
  )
end
