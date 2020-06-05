FactoryBot.define do
  factory :user do
    id { 1 }
    name { "user" }
    email { "user@example.com" }
    password_digest { "MyString" }
  end

  factory :admin_user, class: User do
    id { 2 }
    name { "admin" }
    email { "admin@example.com" }
    password { "0000000" }
    admin { true }
  end
end
