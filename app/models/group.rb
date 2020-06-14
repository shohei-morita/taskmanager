class Group < ApplicationRecord
  has_many :users, through: :group_users, source: :user
  has_many :group_users, dependent: :destroy, source: :user
  validates :group_name, presence: true
end
