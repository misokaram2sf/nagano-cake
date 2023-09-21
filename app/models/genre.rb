class Genre < ApplicationRecord

   has_many :items, dependent: :destroy

   validates :name, presence: true, length: { minimum: 1 }

end
