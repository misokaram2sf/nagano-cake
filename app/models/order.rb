class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :postal_code, presence: true, numericality: true, length: { is: 7 }
  validates :address, presence: true
  validates :name, presence: true

  def full_name
    last_name + '' + first_name
  end

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { payment_waiting: 0, payment_confirmation: 1, in_production: 2, preparing_delivery: 3, delivered: 4 }

end
