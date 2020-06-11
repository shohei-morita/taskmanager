class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :labels, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                  uniqueness: true
  before_validation { email.downcase! }
  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password

  before_destroy :do_not_destroy_last_one_admin
  before_update :do_not_change_last_one_admin

  private

  def do_not_destroy_last_one_admin
    if User.where(admin: true).one? && self.admin?
      throw(:abort)
    end
  end

  def do_not_change_last_one_admin
    if User.where(admin: true).one? && self.admin? == false
      throw(:abort)
    end
  end
end
