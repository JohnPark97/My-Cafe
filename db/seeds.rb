# db/seeds.rb
require 'open-uri'
include S3Helper

def upload_image(file_path, model)
  file = File.open(file_path)
  model.image_url = file
  model.save!
  file.close
  puts "Uploaded #{file_path} to S3."
end

# Create cafes with subdomains
cafe1 = Cafe.find_or_create_by!(name: 'Cafe One', subdomain: 'cafe-one')
cafe2 = Cafe.find_or_create_by!(name: 'Cafe Two', subdomain: 'cafe-two')

# Create categories
category1 = cafe1.categories.find_or_create_by!(name: 'Beverages')
category2 = cafe1.categories.find_or_create_by!(name: 'Snacks')
category3 = cafe2.categories.find_or_create_by!(name: 'Desserts')
category4 = cafe2.categories.find_or_create_by!(name: 'Meals')

# Create menu items with images only if they don't already exist
menu_item1 = category1.menu_items.find_or_create_by!(
  name: 'Espresso',
  description: 'Strong and rich coffee.',
  price: 2.99,
  availability: true,
  cafe: cafe1
)
upload_image('db/seeds/images/espresso.jpeg', menu_item1)

menu_item2 = category2.menu_items.find_or_create_by!(
  name: 'Chocolate Chip Cookie',
  description: 'Freshly baked with lots of chocolate chips.',
  price: 1.49,
  availability: true,
  cafe: cafe1
)
upload_image('db/seeds/images/cookie.jpg', menu_item2)

menu_item3 = category3.menu_items.find_or_create_by!(
  name: 'Cheesecake',
  description: 'Creamy cheesecake with a graham cracker crust.',
  price: 3.99,
  availability: true,
  cafe: cafe2
)
upload_image('db/seeds/images/cheesecake.jpeg', menu_item3)

menu_item4 = category4.menu_items.find_or_create_by!(
  name: 'Chicken Sandwich',
  description: 'Grilled chicken sandwich with lettuce and tomato.',
  price: 5.99,
  availability: true,
  cafe: cafe2
)
upload_image('db/seeds/images/chicken_sandwich.jpeg', menu_item4)

puts 'Seeding complete!'
