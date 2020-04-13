# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do

    sequence :name do |n|
      "task_#{n}"
    end

    sequence :detail do |n|
      "task_#{n}_detail"
    end

    deadline { 1.month.ago }
    status { :waiting }
    priority { :low }

    trait :old do
      deadline { 2.month.ago }
      status { :completed }
    end

    user

  end
end
