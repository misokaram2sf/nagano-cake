class Item < ApplicationRecord

  has_one_attached :image

  has_many :cart_item, dependent: :destroy

  TAX_RATE = 10

  def with_tax_price
   (price * (1 + TAX_RATE * 0.01)).floor
  end

end
