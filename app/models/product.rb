class Product < ApplicationRecord
  belongs_to :user
  has_many :recipeingredients, dependent: :destroy

  validates :product_name, :description, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_product_name_and_description,
    against: [ :product_name, :description ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
