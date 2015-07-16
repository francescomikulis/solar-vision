# Hardcodes users

User.create!(name: "Example User",
              email: "example@railstutorial.org",
              password:              "foobar",
              password_confirmation: "foobar",
              admin: true,
              activation_email_sent: Time.zone.now,
              activated: true,
              activated_at: Time.zone.now)

# My personal accounts

User.create!(name: "Francesco Mikulis",
              email: "francescomikulis@yahoo.com",
              password:              "foobar",
              password_confirmation: "foobar",
              admin: true,
              activation_email_sent: Time.zone.now,
              activated: true,
              activated_at: Time.zone.now)
User.create!(name: "Francesco Mikulis",
              email: "francescomikulis@gmail.com",
              password:              "foobar",
              password_confirmation: "foobar",
              admin: true,
              activation_email_sent: Time.zone.now,
              activated: true,
              activated_at: Time.zone.now)
User.create!(name: "Francesco Mikulis",
              email: "francescomikulis@live.com",
              password:              "foobar",
              password_confirmation: "foobar",
              admin: true,
              activation_email_sent: Time.zone.now,
              activated: true,
              activated_at: Time.zone.now)              

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+4}@railstutorial.org"
  password = "password"
  User.create!(name:                 name,
              email:                 email,
              password:              password,
              password_confirmation: password,
              activation_email_sent: Time.zone.now,
              activated: true,
              activated_at: Time.zone.now)

end

# Microposts
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Following relationships

#users = User.all
#user = users.first
#following = users[2..50]
#followers = users[3..40]
#following.each { |single_followed_user| user.follow(single_followed_user) }
#followers.each { |single_follower_user| single_follower_user.follow(user) }
