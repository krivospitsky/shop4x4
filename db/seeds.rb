# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create! :email => 'test@test.com', :password => 'testtest', :password_confirmation => 'testtest'
cat=Category.create! name: "Фотоаппараты"
Category.create! name: "Зеркальные", parent: cat