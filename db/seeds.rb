# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: 'test1', email: 'abc@dpro.com', password: 'hogehoge', password_confirmation: 'hogehoge' )
User.create(name: 'test2', email: 'def@dpro.com', password: 'fugafuga', password_confirmation: 'fugafuga' )