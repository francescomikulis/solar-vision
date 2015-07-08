User.create!(name: "Example User",
              email: "example@railstutorial.org",
              password:              "foobar",
              password_confirmation: "foobar",
              admin: true,
              activated:    true,
              activated_at: Time.zone.now)
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:                 name,
              email:                 email,
              password:              password,
              password_confirmation: password,
              activated:    true,
              activated_at: Time.zone.now)
              
# My personal accounts

User.create!(name: "Francesco Mikulis",
              email: "francescomikulis@yahoo.com",
              password:              "foobar",
              password_confirmation: "foobar",
              admin: true,
              activated:    true,
              activated_at: Time.zone.now)
User.create!(name: "Francesco Mikulis",
              email: "francescomikulis@gmail.com",
              password:              "foobar",
              password_confirmation: "foobar",
              admin: true,
              activated:    true,
              activated_at: Time.zone.now)
User.create!(name: "Francesco Mikulis",
              email: "francescomikulis@live.com",
              password:              "foobar",
              password_confirmation: "foobar",
              admin: true,
              activated:    true,
              activated_at: Time.zone.now)
end