class Recipe < ApplicationRecord
  has_many :favourites
  has_many :recipeingredients
  has_many :products, through: :recipeingredients
  has_one_attached :photo
  validates :recipe_name, :instructions, :prep_time, :cooking_time, :level, presence: true

  def favourite(user)
    user.favourites.include?(self)
  end
end
