class Task < ApplicationRecord
  validates :theme, presence: true
  validates :content, presence: true
end
