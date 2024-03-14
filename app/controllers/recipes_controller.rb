class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def generate
    @titles = RecipeGenerator.new(params[:ingredients]).generate
  end

  def create
    @recipes = Recipe.new(recipe_params)
  end
end
