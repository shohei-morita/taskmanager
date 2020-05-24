module TasksHelper
  def choose_new_or_edit
    if action_name == "new" || action_name == "create" || action_name === "confirm"
      confirm_tasks_path
    else action_name == "edit"
      task_path
    end
  end

  def priority_description
    if @task.priority == 1
      "低い"
    elsif @task.priority == 2
      "普通"
    else
      "高い"
    end
  end

    def status_description
      if @task.status == 1
        "未着手"
      elsif @task.status == 2
        "普通"
      else
        "完了"
      end
    end
end
