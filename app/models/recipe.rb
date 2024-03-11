class Recipe < ApplicationRecord
  has_many :favourites
  has_many :recipe_ingredients
  validates :recipe_name, :instructions, :prep_time, :cooking_time, :level, presence: true
end
