class ReminderMailer < ApplicationMailer
  def remind
    @tasks = Task.remind_limit
    @tasks.each do |task|
      mail to: task.user.email, subject: "タスク期限のご連絡"
    end
  end
end
