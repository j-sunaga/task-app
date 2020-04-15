class Label < ApplicationRecord

  #association
  has_many :labelings, dependent: :destroy
  has_many :labelings_tasks, through: :labelings, source: :task

  validates :name, presence: true, length: { in: 1..50 }
end
