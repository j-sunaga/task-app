#User初期データ
20.times do |n|
    User.create(
      email: "test_#{n + 1}@test.com",
      name: "test_#{n + 1}",
      password: '123456'
    )
  end

#Admin初期データ
2.times do |n|
    User.create(
      email: "admin_#{n + 1}@test.com",
      name: "admin_#{n + 1}",
      password: '123456',
      admin: true
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

  user.labels.create(
    name: user.name + '_label'
  )

  Labeling.create(
    task_id: user.tasks.first.id,
    label_id: user.labels.first.id
  )

end
