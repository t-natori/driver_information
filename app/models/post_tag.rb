class PostTag < ApplicationRecord

  belongs_to :post
  belongs_to :tag

# このバリデーションをかけるとエラーになる
# 空の器にpost_idを入れるのにからはだめだと言ってしまうイメージ
  #validates :post_id, presence: true
  #validates :tag_id, presence: true

end
