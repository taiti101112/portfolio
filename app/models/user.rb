class User < ApplicationRecord
  # Deviseのモジュール設定
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  # バリデーション（Googleログイン時に特定のバリデーションを回避）
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, unless: -> { provider.present? }
  validates :uid, uniqueness: { scope: :provider }

  # アソシエーション
  has_many :favorites, dependent: :destroy
  has_many :favorite_shops, through: :favorites, source: :shop

  # お気に入り関連メソッド
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

  # OmniAuthによるユーザー検索・作成
  def self.from_omniauth(auth)
    user = find_by(email: auth[:info][:email])
  
    if user
      # 既存ユーザーの場合、名前やプロバイダー情報を更新
      user.update(
        provider: auth[:provider],
        uid: auth[:uid],
        name: auth[:info][:name].presence || user.name || "Googleユーザー"
      )
    else
      # 新規ユーザー作成
      user = User.new(
        provider: auth[:provider],
        uid: auth[:uid],
        email: auth[:info][:email],
        name: auth[:info][:name].presence || "Googleユーザー",
        password: Devise.friendly_token[0, 20]
      )
    end
  
    if user.save
      user
    else
      Rails.logger.error "OmniAuth error: #{user.errors.full_messages.join(", ")}"
      nil
    end
  end
  
  
end
