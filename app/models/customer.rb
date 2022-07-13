class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  # アソシエーション
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  #バリデーション
  validates :name, presence: true
  validates :name_kana, presence: true
  validates :nickname, presence: true
  validates :phone_number, presence: true

  def self.guest
    find_or_create_by!(name: 'guestcustomer', name_kana: 'ゲストカスタマー', nickname: 'ゲスト', phone_number: '09012345678' ,email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "guestcustomer"
    end
  end


end
