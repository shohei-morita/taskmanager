class RemoveTaskIdFormLabels < ActiveRecord::Migration[5.2]
  def up
    remove_column :labels, :task_id
  end

  def down
    add_column :labels, :task_id, :bigint
  end
end
