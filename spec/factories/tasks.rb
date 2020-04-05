# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do

    name { 'task' }
    detail { 'task_detail' }
    deadline { 1.month.ago }
    status { :waiting }
    priority { :low }

    trait :old_task do
      name { 'old_task' }
      detail { 'old_task_detail' }
      deadline { 2.month.ago }
      status { :completed }
    end

    trait :high_priority do
      name { 'high_task' }
      detail { 'high_task_detail' }
      priority { :high }
    end

    trait :task_list do
      sequence :name do |n|
        "task_#{n}"
      end
      sequence :detail do |n|
        "task_#{n}_detail"
      end
      status { :working }
    end

  end
end
