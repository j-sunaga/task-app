FactoryBot.define do
  factory :labeling do
    task_id { 1 }
    label_id { 1 }
    task
    label
  end
end
