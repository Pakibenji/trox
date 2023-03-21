# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
10.times do
    Tool.create(title: Faker::Appliance.equipment, description: Faker::Lorem.paragraph, pic: Faker::LoremFlickr.image(size: "50x60", search_terms: ['tool']), location: Faker::Address.state, condition: Faker::Emotion.adjective, caution: Faker::Number.decimal(l_digits: 2))
end