class User < ApplicationRecord

  before_destroy :stop_admin_destroy
  before_update :stop_admin_update

  #アソシエーション
  has_many :tasks, dependent: :destroy

  #secure password
  has_secure_password

  #validation
  before_validation { email.downcase! }
  validates :name, presence: true, length: {maximum: 30}
  validates :email, presence: true,  uniqueness: true, length: {maximum: 255},format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password,presence: true, length: { minimum: 6 }

  #scope
  scope :name_like,  -> (query) { where('name LIKE ?', "%#{query}%") }
  scope :name_order, -> { order(name: :asc) }

  #call back
  private
  def stop_admin_destroy
    if User.where(admin: true).count == 1
      if self.admin == true
        throw(:abort)
      end
    end
  end

  def stop_admin_update
    if User.where(admin: true).count == 1
      if self.admin == true
        throw(:abort)
      end
    end
  end

end
