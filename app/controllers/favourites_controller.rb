require 'open-uri'

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
      favourited_recipe_ids = Favourite.pluck(:recipe_id).uniq
      set_photo(@recipe.recipe_name)
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

  private

  def set_photo(recipe)
    recipe_name = recipe
    client = OpenAI::Client.new
    response = client.images.generate(parameters: {
      prompt: "Generate a visually appealing image of #{recipe_name}. Please enusre a dark background",
      size: "1024x1024"
    })

    image_url = response["data"][0]["url"]
    file =  URI.open(image_url)

    @recipe.photo.purge if @recipe.photo.attached?
    @recipe.photo.attach(io: file, filename: "ai_generated_image_#{recipe.parameterize}.jpg", content_type: "image/png")

    return @recipe.photo
  end
end
