class FavouritesController < ApplicationController
  def index
    if params[:query].present?
      @favourites = Favourite.search_by_recipe_name(params[:query])
    else
      @favourites = current_user.favourites
    end
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @favourite = Favourite.new(user_id: current_user.id, recipe_id: @recipe.id)

    if @favourite.save
      # Identify Recipe IDs that have been favourited
      favourited_recipe_ids = Favourite.pluck(:recipe_id).uniq
      # generate_image_for_recipe(@recipe.recipe_name)
      # Delete Recipes that have not been favourited
      Recipe.where.not(id: favourited_recipe_ids).destroy_all

      redirect_to favourites_path, notice: "Recipe favourited successfully"
    else
      redirect_to recipes_path, alert: "Failed to favourite recipe"
    end
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @favourite.destroy
    redirect_to favourites_path, status: :see_other
  end

  # private

  # def generate_image_for_recipe(recipe_name)
  #   prompt = "Generate a visually appealing image of #{recipe_name} made with #{@ingredients.join(' ')}. Please enusre a dark background."

  #   response = client.images.generate(parameters: { prompt: prompt, size: "256x256" })
  #   image_url = response.dig("data", 0, "url")

  #   puts "Generated image for recipe #{recipe_name}: #{image_url}"
  #   image_url
  # end
end
