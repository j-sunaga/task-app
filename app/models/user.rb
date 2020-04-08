class User < ApplicationRecord

  #アソシエーション
  has_many :tasks

  #secure password
  has_secure_password

  #validation
  before_validation { email.downcase! }
  validates :name, presence: true, length: {maximum: 30}
  validates :email, presence: true,  uniqueness: true, length: {maximum: 255},format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password,presence: true, length: { minimum: 6 }

end
