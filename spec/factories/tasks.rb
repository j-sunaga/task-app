FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    task_name { 'test_title' }
    detail { 'test_detail' }
    deadline { Date.today }
    status { 'test_status' }
    priority { 'test_priority' }
  end
end
