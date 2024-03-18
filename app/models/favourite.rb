class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  include PgSearch::Model
  pg_search_scope :search_by_recipe_name,
                  associated_against: {
                    recipe: [:recipe_name]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
end
