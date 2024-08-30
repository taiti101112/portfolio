class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  has_many :favorites, dependent: :destroy
  has_many :favorite_shops, through: :favorites, source: :shop

  def favorite(shop)
    favorite_shops << shop
  end

  def unfavorite(shop)
    favorite_shops.destroy(shop)
  end

  def favorite?(shop)
    favorite_shops.include?(shop)
  end

  def admin?
    admin
  end
  
end
