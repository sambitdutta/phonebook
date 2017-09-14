# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


AddressType.find_or_create_by(name: "Home")
AddressType.find_or_create_by(name: "Work")
AddressType.find_or_create_by(name: "Other")

PhoneType.find_or_create_by(name: "Home")
PhoneType.find_or_create_by(name: "Mobile")
PhoneType.find_or_create_by(name: "Work")
PhoneType.find_or_create_by(name: "Other")

CS.countries.each do |code, name|
  c = Country.find_or_initialize_by(name: name)
  c.code = code.to_s.downcase
  next if c.code == "country_iso_code"
  c.save!
end
  
