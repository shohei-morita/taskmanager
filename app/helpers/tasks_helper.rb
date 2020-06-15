module TasksHelper
  def read_unread(object)
    if object == true
      "既読"
    else
      "未読"
    end
  end
end
