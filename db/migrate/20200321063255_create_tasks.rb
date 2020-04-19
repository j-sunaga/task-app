# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.string :detail
      t.date :deadline
      t.string :status
      t.string :priority
      t.string :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
