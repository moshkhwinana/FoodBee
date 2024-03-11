class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :recipe_name
      t.text :instructions
      t.string :prep_time
      t.string :cooking_time
      t.string :level
      t.float :ratings

      t.timestamps
    end
  end
end
