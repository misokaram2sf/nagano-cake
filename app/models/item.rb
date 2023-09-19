class Item < ApplicationRecord

  belongs_to :cart_items, dependent: :destroy
end
