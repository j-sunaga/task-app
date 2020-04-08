class User < ApplicationRecord

  #アソシエーション
  has_many :tasks

  has_secure_password

end
