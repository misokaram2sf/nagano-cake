class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy


  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :address, presence: true
  validates :postal_code, presence: true, numericality: true, length: { is: 7 }
  validates :phone_number, presence: true, numericality: true

  def full_name
    last_name + '' + first_name
  end

  #ログイン時に退会済みのユーザーが同じアカウントでログイン出来ないようにする。
  # def active_for_authentication?
  #   super && (is_active == false)
  # end

end
