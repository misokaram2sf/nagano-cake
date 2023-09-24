class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy
  
  validates :name, presence: true
  validates :postal_code, presence: true, numericality: {only_integer: true}, length: { is: 7 }
  validates :address, presence: true
  validates :name, presence: true

  def full_name
    last_name + '' + first_name
  end
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  

end
