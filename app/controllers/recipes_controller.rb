
class RecipeController < ApplicationController
  def index
  end

  def show
    @recipe = Recipe.find(params[:id])
    ingredients = params[:ingredients]&.split(',')&.map(&:strip) || []
    generator = RecipeGenerator.new(ingredients)
    @generated_recipe_content = generator.generate
  end

  def generate
    @titles = RecipeGenerator.new(params[:ingredients]).generate
  end

  def create
    @recipe = Recipe.new(recipe_params)
  end
end
