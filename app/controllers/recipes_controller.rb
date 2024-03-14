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
    products = Product.all
    # generates recipes and saves them in DB
    RecipeGenerator.new(products).generate
    redirect_to recipes_path
  end

  def create
    @recipe = Recipe.new(recipe_params)
  end
end
