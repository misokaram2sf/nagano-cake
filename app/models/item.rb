class Item < ApplicationRecord

  has_one_attached :image
  has_many :cart_items, dependent: :destroy
  has_many :order_details
  belongs_to :genre

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true

  TAX_RATE = 10

  def with_tax_price
   (price * (1 + TAX_RATE * 0.01)).floor
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def total_item_amount #アイテム合計金額
   order_details.sum { |order_detail| order_detail.subtotal }
  end
  
  

end
