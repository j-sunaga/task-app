class ChangeColumnToTask < ActiveRecord::Migration[5.2]
    # 変更内容
  def up
    change_column :tasks, :name, :string, null: false, default: ""
    change_column :tasks, :detail, :string, null: false, default: ""
    change_column :tasks, :deadline, :date, null: false
    change_column :tasks, :status, :string, null: false
    change_column :tasks, :priority, :string, null: false
    change_column :tasks, :name, :string, limit: 50
    change_column :tasks, :detail, :string, limit: 200
    change_column_default :tasks, :deadline, from: "2020-03-29" , to: nil
  end


  # 変更前の状態
  def down
  end

end
