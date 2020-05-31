class Task < ApplicationRecord
  validates :theme, presence: true
  validates :content, presence: true

  #def self.search(search)
  #  if search
  #    Task.where(['theme LIKE ?', "%#{search}%"])
  #  else
  #    Task.all
  #  end
  #end
end
