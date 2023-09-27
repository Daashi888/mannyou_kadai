class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }

  before_validation { email.downcase! }

  has_secure_password

  has_many :tasks, dependent: :destroy

  before_destroy :admin_cannot_delete

private

  def admin_cannot_delete
    if User.where(admin: true).count == 1 && self.admin
      throw :abort
    end
  end
end
