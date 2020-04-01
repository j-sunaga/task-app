class ChangeDatatypePriorityOfTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :priority, 'integer USING CAST(status AS integer)'
  end
end
