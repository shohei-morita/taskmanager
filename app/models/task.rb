class Task < ApplicationRecord
  validates :theme, presence: true
  validates :content, presence: true

  scope :search_theme, -> (search) { where("theme LIKE ?", "%#{search}%") }
  scope :search_status, -> (search) { where(status: search) }

  enum status: { yet: 1, doing: 2, done: 3 }
  enum priority: { low: 1, middle: 2, high: 3 }
end
