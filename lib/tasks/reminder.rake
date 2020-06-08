namespace :reminder do
  desc "リマインドメール"
  task reminder_mail: :environment do
      ReminderMailer.remind.deliver
  end
end
