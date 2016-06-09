# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(first_name: "Mikko",
             last_name:  "Kärkkäinen",
             email: "asdf@railstutorial.org",
             password:              "foobars",
             password_confirmation: "foobars",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(first_name: "Mikko",
             last_name:  "Kärkkäinen",
             email: "fdsa@railstutorial.org",
             password:              "foobars",
             password_confirmation: "foobars",
             activated: true,
             activated_at: Time.zone.now)

Topic.create!(	title: "ASDFASFDSAFsda",
				content: "asdfasdfsfdsafdsa",
				user_id:1,			
	)

