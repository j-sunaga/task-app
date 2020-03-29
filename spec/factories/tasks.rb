FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    name { 'test_title' }
    detail { 'test_detail' }
    deadline { Random.rand(Date.parse("2020/01/01") .. Date.parse("2020/03/30")) }
    status { 'test_status' }
    priority { 'test_priority' }
  end
end
