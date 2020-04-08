# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「user」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :user do

    sequence :name do |n|
      "test_#{n+1}"
    end

    sequence :email do |n|
      "test_#{n+1}@test.com"
    end

    password {'123456'}

  end
end
