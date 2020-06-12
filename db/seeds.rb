name = "test_user"
name2 = "test_admin"
email = "test@mail.com"
email2 = "admin@mail.com"
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
