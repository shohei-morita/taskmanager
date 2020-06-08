class Task < ApplicationRecord
  belongs_to :user
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels


  validates :theme, presence: true
  validates :content, presence: true

  scope :search_theme, -> (search) { where("theme LIKE ?", "%#{search}%") }
  scope :search_status, -> (search) { where(status: search) }
  scope :search_label, -> (search) { where(id: TaskLabel.where(label_id: search).pluck(:task_id)) }

  enum status: { yet: 1, doing: 2, done: 3 }
  enum priority: { low: 1, middle: 2, high: 3 }
end
