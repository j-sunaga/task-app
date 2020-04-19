# frozen_string_literal: true

class Label < ApplicationRecord
  has_many :labelings, dependent: :destroy
  has_many :tasks, through: :labelings
  belongs_to :user, optional: true

  validates :name, presence: true, length: { in: 1..50 }
end
