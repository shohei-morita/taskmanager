class AddIndexTasksStatusPriority < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, [:priority, :status]
  end
end
