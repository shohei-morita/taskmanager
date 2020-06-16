class Task < ApplicationRecord
  belongs_to :user
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels

  has_one_attached :image

  validates :theme, presence: true
  validates :content, presence: true

  scope :search_theme, -> (search) { where("theme LIKE ?", "%#{search}%") }
  scope :search_status, -> (search) { where(status: search) }
  scope :search_label, -> (search) { where(id: TaskLabel.where(label_id: search).pluck(:task_id)) }
  scope :near_limit, -> { where(time_limit: Time.zone.today..Time.zone.today + 2).where.not(status: 3) }
  scope :time_over, -> { where("time_limit <= ?", Time.zone.today - 1).where.not(status: 3) }

  enum status: { yet: 1, doing: 2, done: 3 }
  enum priority: { low: 1, middle: 2, high: 3 }

  def start_time
    self.time_limit
  end
end
