class Product < ApplicationRecord
  belongs_to :user
  has_many :recipeingredients, dependent: :destroy

  validates :product_name, :description, presence: true
end
