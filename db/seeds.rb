# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(first_name: "Example",
             last_name:  "User",
             email: "asdf@railstutorial.org",
             password:              "foobars",
             password_confirmation: "foobars",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  first_name = last_name  = Faker::Name.name
  email = "example-#{n}@railstutorial.org"
  password = "password"
  User.create!(first_name:  first_name,
              last_name: last_name,
              email: email,
              password:              password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.topics.create!(content: content) }
end