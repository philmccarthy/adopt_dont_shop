# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shelters = FactoryBot.create_list(:shelter, 5)
shelters.each do |shelter|
  FactoryBot.create_list(:pet, rand(2..7), shelter: shelter)
end