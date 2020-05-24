class AddColumnsToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :priority, :integer, default: 2
    add_column :tasks, :status, :integer, default: 1
    add_column :tasks, :time_limit, :date
  end
end
