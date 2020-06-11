FactoryBot.define do
  factory :label do
    sequence(:label, "test_label1")
    user_id { 1 }
  end
end
