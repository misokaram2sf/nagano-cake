class Item < ApplicationRecord

  has_one_attached :image
  has_many :cart_items, dependent: :destroy
  belongs_to :genre

  TAX_RATE = 10

  def with_tax_price
   (price * (1 + TAX_RATE * 0.01)).floor
  end

end
