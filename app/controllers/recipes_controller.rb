class RecipesController < ApplicationController
  def index
  end

  def show
  end

  def generate
  end

  def create
    @recipes = Recipe.new(recipe_params)
  end
end
