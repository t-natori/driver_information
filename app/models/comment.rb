class Comment < ApplicationRecord

  # アソシエーション
  belongs_to :customer
  belongs_to :post

  #バリデーション
  validates :body, presence: true

end
