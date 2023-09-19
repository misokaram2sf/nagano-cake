class Item < ApplicationRecord

  belongs_to :cart_item, dependent: :destroy
end
