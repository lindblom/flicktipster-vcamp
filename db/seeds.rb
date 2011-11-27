# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

movies = Movie.create([
{title: "Men in black", youtube: "YxQS2taMOl4", year: 1997, description: "Some alian movie", runtime: 154},
{title: "Men in black 2", youtube: "p4NJHqoojOU", year: 2000, description: "Some alian movie 2", runtime: 154},
{title: "Men in black 3", youtube: "LPPqZh-xh7Y", year: 2012, description: "Some alian movie 3", runtime: 154}
])

user = User.new(username: "user", password: "user")
user.password_confirmation = "user"
user.save

admin = User.new(username: "admin", password: "admin")
admin.password_confirmation = "admin"
admin.admin = true
admin.save
