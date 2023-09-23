class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  def full_name
    last_name + '' + first_name
  end

  #ログイン時に退会済みのユーザーが同じアカウントでログイン出来ないようにする。
  # def active_for_authentication?
  #   super && (is_active == false)
  # end

end
