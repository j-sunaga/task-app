class Task < ApplicationRecord
  belongs_to :user,optional: true

  validates :name, presence: true, length: { in: 1..50 }
  validates :detail, presence: true, length: { in: 1..200 }
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true

end
