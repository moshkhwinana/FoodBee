class Product < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients

  validates :product_name, :description, presence: true
end
