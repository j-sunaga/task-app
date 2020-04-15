
#User初期データ
20.times do |n|
    User.create(
      email: "test_#{n + 1}@test.com",
      name: "test_#{n + 1}",
      password: '123456'
    )
  end

#Task初期データ
User.all.each do |user|
  user.tasks.create(
    name: user.name + '_task',
    detail: user.name + '_task_detail',
    deadline: Date.today + rand(-15..15),
    status: Task.statuses.keys.at(rand(0..2)),
    priority: Task.priorities.keys.at(rand(0..2))
  )
end
