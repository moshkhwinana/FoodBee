puts "Destroying all tings"

Recipeingredient.destroy_all
Favourite.destroy_all
Product.destroy_all
User.destroy_all
Recipe.destroy_all

user = User.create!(email: 'finn@test1.com', password: 'password', password_confirmation: 'password', username: 'Nerd')

puts "Created a user: #{user.username}"

avocado = Product.create!(product_name: "Avocado", description: "A creamy textured fruit", user: user)
cilantro = Product.create!(product_name: "Cilantro", description: "A fragrant herb", user: user)
lime = Product.create!(product_name: "Lime", description: "A citrus fruit", user: user)
eggplant = Product.create!(product_name: "Eggplant", description: "A purple, spongy vegetable", user: user)
zucchini = Product.create!(product_name: "Zucchini", description: "A green summer squash", user: user)
bell_pepper = Product.create!(product_name: "Bell Pepper", description: "A colorful vegetable", user: user)

puts "Created some products"

guacamole = Recipe.create(recipe_name: "Guacamole", instructions: "1. Cut the avocados in half. Remove the seed. Scoop out the flesh with a spoon. 2. Using a fork, roughly mash the avocado. 3. Add the chopped cilantro, lime juice, and salt. 4. Stir everything together. 5. Serve with tortilla chips.", prep_time: "10 minutes", cooking_time: "0 minutes", level: "easy", ratings: 5)
ratatouille = Recipe.create(recipe_name: "Ratatouille", instructions: "1. Preheat the oven to 375°F. 2. Slice the eggplant, zucchini, and bell pepper into 1/4-inch thick slices. 3. Spread 1/3 of the tomato sauce on the bottom of a 9x13-inch baking dish. 4. Arrange the eggplant, zucchini, and bell pepper slices over the sauce. 5. Spread 1/3 of the tomato sauce over the vegetables. 6. Repeat the layering process until all the vegetables and sauce are used. 7. Cover the dish with foil and bake for 45 minutes. 8. Uncover and bake for an additional 15 minutes. 9. Serve hot or at room temperature.", prep_time: "20 minutes", cooking_time: "60 minutes", level: "medium", ratings: 4)

puts "Created some recipes"

Favourite.create!(user: user, recipe: guacamole)

puts "Favourited a recipe"
