class Comment < ApplicationRecord
  belongs_to :post

  validates :name, :description, presence: true
end
