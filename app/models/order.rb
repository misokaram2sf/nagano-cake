class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  def full_name
    last_name + '' + first_name
  end

end
