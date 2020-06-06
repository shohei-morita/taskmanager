FactoryBot.define do
  factory :user do
    id { 1 }
    name { "user" }
    email { "user@example.com" }
    password { "0000000" }
    admin { false }
  end

  factory :user2, class: User do
    id { 2 }
    name { "user2" }
    email { "user2@example.com" }
    password { "0000000" }
    admin { false }
  end

  factory :admin, class: User do
    id { 3 }
    name { "admin" }
    email { "admin@example.com" }
    password { "0000000" }
    admin { true }
  end
end
