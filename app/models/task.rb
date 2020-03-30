class Task < ApplicationRecord
  belongs_to :user,optional: true

  enum status: {uncompleted: 0, completed: 1}
  enum priority: {low: 0, middle: 1, high: 2}

end
