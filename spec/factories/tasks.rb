FactoryBot.define do
  factory :task do
    theme { 'test_theme1' }
    content { 'test_content1' }
    time_limit { Date.new(2020, 6, 5) }
    status { 1 }
    priority { 1 }
    user
  end

  factory :second_task, class: Task do
    theme { 'test_theme2' }
    content { 'test_content2' }
    time_limit { Date.new(2020, 6, 6) }
    status { 1 }
    priority { 2 }
    user
  end

  factory :third_task, class: Task do
    theme { 'test3' }
    content { 'test3' }
    time_limit { Date.new(2020, 6, 7) }
    status { 2 }
    priority { 3 }
    user
  end
end
