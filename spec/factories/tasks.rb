FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    status { 0 }
    # priority { 0 }

  end

  factory :second_task, class: Task do
    title { 'test_title2' }
    content { 'test_content2' }
    status { 1 }
    # priority { 0 }
  end
end
