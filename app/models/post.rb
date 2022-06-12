class Post < ApplicationRecord

  # アソシエーション
  has_many :favorites, dependent: :destroy
  belongs_to :customer
  belongs_to :genre

# 引数で渡されたcutomer_idがhavoritesテーブルに存在していれば「true」
def favorited_by?(customer)
  favorites.exists?(customer_id: customer.id)
end

#バリデーション
validates :name, presence: true
validates :address, presence: true
validates :type, presence: true
validates :recommend, presence: true
validates :clean, presence: true
validates :parking, presence: true
validates :status, presence: true


end