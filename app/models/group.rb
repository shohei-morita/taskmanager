class Group < ApplicationRecord
  belongs_to :user
  validates :group_name, presence: true
end
