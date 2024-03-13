class RecipeController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = @recipes.find(params[:id])
  end

  def generate
  end

  def create
    @recipes = Recipe.new(recipe_params)
  end
end
