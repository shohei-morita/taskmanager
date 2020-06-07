class AddIndexToTasksLabels < ActiveRecord::Migration[5.2]
  def change
    add_index :task_labels, [:task_id, :label_id]
  end
end
