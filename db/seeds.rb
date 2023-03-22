# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?


10.times do
    Tool.create(
      title: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      pic: Faker::LoremFlickr.image,
      loaned: false,
      location: Faker::Address.city,
      caution: Faker::Commerce.price(range: 50..100),
      condition: Faker::Lorem.word,
      user_id: rand(1..10)
    )
  end
  
  # Création des utilisateurs
  10.times do
    User.create(
      email: Faker::Internet.unique.email,
      password: "password1",
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      phone: Faker::PhoneNumber.phone_number,
      address: Faker::Address.street_address,
      address_complement: Faker::Address.secondary_address,
      postcode: Faker::Address.zip_code,
      image_url: Faker::LoremFlickr.image(size: "50x50")
    )
  end
  
  # Création des prêts aléatoires
  10.times do
    Loan.create(
      start_date: Faker::Date.between(from: 1.year.ago, to: Date.today),
      end_date: Faker::Date.between(from: Date.today, to: 1.year.from_now),
      user_id: rand(1..10),
      tool_id: rand(1..10)
    )
  end