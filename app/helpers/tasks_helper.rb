module TasksHelper
  def choose_new_or_edit
    if action_name == "new" || action_name == "create" || action_name === "confirm"
      confirm_tasks_path
    else action_name == "edit"
      task_path
    end
  end

  def priority_labels
    { 低い: 1,  普通: 2, 高い: 3 }
  end

  def status_labels
    { 未着手: 1, 着手中: 2, 完了: 3 }
  end

end
