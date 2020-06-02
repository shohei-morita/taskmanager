name = Faker::Games::Pokemon.name
email = Faker::Internet.email
password = "pasword"
User.create!(name: name,
             email: email,
             password_digest: password,
            )
