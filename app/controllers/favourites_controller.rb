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
end
