class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :title, :text, presence: true
end
