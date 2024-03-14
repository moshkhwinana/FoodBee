class FavouritesController < ApplicationController
  def index
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    current_user.favourites << recipe
    redirect_to recipes_path, notice: "Recipe favourited"
  end

  def destroy
  end
end
