class Task < ApplicationRecord
  belongs_to :user,optional: true

  validates :name, presence: true, length: { in: 1..50 }
  validates :detail, presence: true, length: { in: 1..200 }
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  enum status: {uncompleted: 0, completed: 1}
  enum priority: {low: 0, middle: 1, high: 2}

end
