class Post < ApplicationRecord

  # アソシエーション
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy

  belongs_to :customer
  belongs_to :genre

# 引数で渡されたcutomer_idがfavoritesテーブルに存在していれば「true」
def favorited_by?(customer)
  favorites.exists?(customer_id: customer.id)
end

#バリデーション

validates :latitude, presence: true
validates :longitude, presence: true
validates :name, presence: true
validates :address, presence: true
validates :detail, presence: true

#星評価5以下1以上
validates :recommend, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true

validates :clean, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true
# validates :parking, presence: true
validates :status, inclusion: [true, false]

# enum status:{release: true, unrelease: false}

  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("address LIKE?","#{word}")
    elsif search == "partial_match"
      @post = Post.where("address LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end

end
