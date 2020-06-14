class AddContentToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :content, :text
  end
end
