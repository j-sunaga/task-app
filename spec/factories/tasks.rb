FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    name { 'test_name' }
    detail { 'test_detail' }
    deadline { 1.month.ago }
    status { 'test_status' }
    priority { 'test_priority' }
  end
end
