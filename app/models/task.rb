# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user, optional: true
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings

  validates :name, presence: true, length: { in: 1..50 }
  validates :detail, presence: true, length: { in: 1..200 }
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  enum status: { waiting: 0, working: 1, completed: 2 }
  enum priority: { low: 0, middle: 1, high: 2 }

  scope :name_like, ->(query) { where('name LIKE ?', "%#{query}%") }
  scope :deadline, -> { order(:deadline) }
  scope :priority, -> { order(priority: :desc) }
  scope :recent, -> { order(created_at: :desc) }

  def self.filter(current_user, input_name, input_status, input_label, page_number)
    input_label.present? ? tasks = current_user.labels.find_by(name: input_label).tasks : tasks = current_user.tasks
    search(tasks, input_name, input_status, page_number)
  end

  def self.search(tasks, input_name, input_status, page_number)
    if input_name.present? && input_status.present?
      tasks.page(page_number).name_like(input_name).where(status: input_status)
    elsif input_name.blank? && input_status.present?
      tasks.page(page_number).where(status: input_status)
    elsif input_name.present? && input_status.blank?
      tasks.page(page_number).name_like(input_name)
    else
      tasks.page(page_number).recent
    end
  end
end
