# frozen_string_literal: true

class ChangeColumnToLabel < ActiveRecord::Migration[5.2]
  def change
    change_column :labels, :name, :string, null: false, default: ''
    change_column :labels, :name, :string, limit: 50
  end
end
