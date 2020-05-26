FactoryBot.define do
  factory :task do
    theme { 'test_theme1' }
    content { 'test_content1' }
  end

  factory :second_task, class: Task do
    theme { 'test_theme2' }
    content { 'test_content2' }
  end
end
