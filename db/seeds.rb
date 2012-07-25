# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
##
##roles = Role.create([{name: 'super_admin'}, {name: 'staff'}, {name:'customer'}])
users = User.create([{email: 'admin@admin.com', password: 'admin123', password_confirmation: 'admin123', admin: true}])

### rake db:seed

