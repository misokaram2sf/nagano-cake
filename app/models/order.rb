class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  def full_name
    last_name + '' + first_name
  end
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  

end
