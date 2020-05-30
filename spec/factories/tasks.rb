FactoryBot.define do
  factory :task do
    theme { 'test_theme1' }
    content { 'test_content1' }
    time_limit { Date.new(2020, 6, 5) }
  end

  factory :second_task, class: Task do
    theme { 'test_theme2' }
    content { 'test_content2' }
    time_limit { Date.new(2020, 6, 6) }
  end
end
