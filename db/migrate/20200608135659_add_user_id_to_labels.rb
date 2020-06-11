class AddUserIdToLabels < ActiveRecord::Migration[5.2]
  def change
    add_column :labels, :user_id, :bigint, index: true
    add_foreign_key :labels, :users, column: :user_id
  end
end
