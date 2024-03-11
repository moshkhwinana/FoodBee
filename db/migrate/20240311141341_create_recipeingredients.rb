class CreateRecipeingredients < ActiveRecord::Migration[7.1]
  def change
    create_table :recipeingredients do |t|
      t.string :quantity
      t.string :unit
      t.references :recipe, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
