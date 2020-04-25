# frozen_string_literal: true

class Label < ApplicationRecord
  has_many :labelings, dependent: :destroy
  has_many :tasks, through: :labelings
  belongs_to :user, optional: true

  validates :name, presence: true, length: { in: 1..50 }
  validate :cannot_save_same_label

  def cannot_save_same_label
    # update
    if id.present?
      name_duplicate_error if Label.find(id).name != name
    # create
    else
      name_duplicate_error
    end
  end

  def name_duplicate_error
    msg = ': 同じ名前のラベルを保存することはできません'
    errors.add(:name, msg) if Label.where(user: user_id, name: name).present?
  end
end
