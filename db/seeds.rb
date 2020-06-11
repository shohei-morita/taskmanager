name = Faker::Games::Pokemon.name
name2 = Faker::Games::Pokemon.name
email = Faker::Internet.email
email2 = Faker::Internet.email
password = "password"
User.create!(name: name,
             email: email,
             password: password,
             password_confirmation: password,
            )
User.create!(name: name2,
             email: email2,
             password: password,
             password_confirmation: password,
             admin: true
)

5.times do |i|
  Label.create!(label: "sample#{i + 1}")
end
