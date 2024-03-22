class RecipesController < ApplicationController
  def index
    favourite_recipe_ids = Favourite.pluck(:recipe_id)
    @recipes = Recipe.where.not(id: favourite_recipe_ids).order(created_at: :desc)
  end

  def show
    @back_path = request.referer ? :back : favourites_path
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def new_generation
    if params[:query].present?
      @products = Product.search_by_product_name_and_description(params[:query])
    else
      @products = Product.all
    end
  end

  def generate
    product_ids = Array.wrap(params[:product_ids]).reject(&:blank?)
    products = Product.where(id: product_ids)
    RecipeGenerator.new(products).generate
    redirect_to recipes_path, notice: "Recipes generated successfully."
  end

  def create
    @recipe = Recipe.new(recipe_params)
  end
end
