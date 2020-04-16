FactoryBot.define do
  factory :label do

    sequence :name do |n|
      "label_#{n}"
    end

    user

  end
end
