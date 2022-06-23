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

def save_tag(sent_tags)
  current_tags = self.tags.pluck(:name) unless self.tags.nil?
  old_tags = current_tags - sent_tags
  new_tags = sent_tags - current_tags

  old_tags.each do |old|
    self.tags.delete Tag.find.by(name: old)
  end

  new_tags.each do |new|
    new_post_tag = Tag.find_or_create_by(name: new)
    self.tags << new_post_tag
  end
end


#バリデーション
validates :name, presence: true
validates :address, presence: true
# validates :type, presence: true

#星評価5以下1以上
validates :recommend, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true

validates :clean, presence: true
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
