require 'open-uri'
include S3Helper

def upload_image(file_path, model)
  file = File.open(file_path)
  model.image_url = file
  model.save!
  file.close
  puts "Uploaded #{file_path} to S3."
end

def within_schema(schema)
  original_schema = ActiveRecord::Base.connection.schema_search_path
  ActiveRecord::Base.connection.schema_search_path = schema
  yield
ensure
  ActiveRecord::Base.connection.schema_search_path = original_schema
end

# Seed data for each cafe schema
[
  { schema: 'cafe_one', cafe_name: 'Cafe One', cafe_subdomain: 'cafe_one', user: 'cafeone' },
  { schema: 'cafe_two', cafe_name: 'Cafe Two', cafe_subdomain: 'cafe_two', user: 'cafetwo' }
].each do |cafe_data|
  within_schema(cafe_data[:schema]) do
    # Create cafes within each schema
    cafe = Cafe.find_or_create_by!(name: cafe_data[:cafe_name], subdomain: cafe_data[:cafe_subdomain])

    # Create categories
    category1 = Category.find_or_create_by!(name: 'Beverages', cafe: cafe)
    category2 = Category.find_or_create_by!(name: 'Snacks', cafe: cafe)
    category3 = Category.find_or_create_by!(name: 'Desserts', cafe: cafe)
    category4 = Category.find_or_create_by!(name: 'Meals', cafe: cafe)

    # Create menu items with images only if they don't already exist
    menu_item1 = category1.menu_items.find_or_create_by!(
      name: 'Espresso',
      description: 'Strong and rich coffee.',
      price: 2.99,
      availability: true,
      cafe: cafe
    )
    upload_image('db/seeds/images/espresso.jpeg', menu_item1)

    menu_item2 = category2.menu_items.find_or_create_by!(
      name: 'Chocolate Chip Cookie',
      description: 'Freshly baked with lots of chocolate chips.',
      price: 1.49,
      availability: true,
      cafe: cafe
    )
    upload_image('db/seeds/images/cookie.jpg', menu_item2)

    menu_item3 = category3.menu_items.find_or_create_by!(
      name: 'Cheesecake',
      description: 'Creamy cheesecake with a graham cracker crust.',
      price: 3.99,
      availability: true,
      cafe: cafe
    )
    upload_image('db/seeds/images/cheesecake.jpeg', menu_item3)

    menu_item4 = category4.menu_items.find_or_create_by!(
      name: 'Chicken Sandwich',
      description: 'Grilled chicken sandwich with lettuce and tomato.',
      price: 5.99,
      availability: true,
      cafe: cafe
    )
    upload_image('db/seeds/images/chicken_sandwich.jpeg', menu_item4)

    # Create admin user for each cafe
    User.find_or_create_by!(email: "admin@#{cafe_data[:user]}.com") do |user|
      user.password = ENV['ADMIN_PASSWORD']
      user.password_confirmation = ENV['ADMIN_PASSWORD']
      user.admin = true
      user.cafe = cafe
    end
  end
end

puts 'Seeding complete!'
