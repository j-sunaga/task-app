class Task < ApplicationRecord
  belongs_to :user,optional: true

  validates :name, presence: true, length: { in: 1..50 }
  validates :detail, presence: true, length: { in: 1..200 }
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  enum status: {waiting: 0,working: 1, completed: 2}
  enum priority: {low: 0, middle: 1, high: 2}

  scope :name_like,  -> (query) { where('name LIKE ?', "%#{query}%") }
  scope :status, -> (query) { where(status: "#{query}") }
  scope :deadline, -> { order(deadline: :desc) }
  scope :priority, -> { order(priority: :desc) }
  scope :recent, -> { order(:created_at) }

end
