class User < ApplicationRecord
  has_many :posts

  validates :name, :email, :password_digest, presence: true
  validates :email, uniqueness: true
end
