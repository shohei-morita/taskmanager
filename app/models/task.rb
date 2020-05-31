class Task < ApplicationRecord
  validates :theme, presence: true
  validates :content, presence: true

  scope :search_theme, -> (search) { where("theme LIKE ?", "%#{search}%") }
  scope :search_status, -> (search) { where(status: search) }

end
