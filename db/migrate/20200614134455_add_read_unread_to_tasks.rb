class AddReadUnreadToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :read_unread, :boolean, default: false
  end
end
