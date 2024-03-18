class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all.order(created_at: :desc)
  end

  def show
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
    # Assuming the name of the parameter is `:product_ids` and it contains the IDs of selected products
    product_ids = Array.wrap(params[:product_ids]).reject(&:blank?) # Reject any empty values
    products = Product.where(id: product_ids) # Retrieve only the selected products

    # generates recipes and saves them in DB with the selected products
    RecipeGenerator.new(products).generate
    redirect_to recipes_path, notice: "Recipes generated successfully."
  end

  def create
    @recipe = Recipe.new(recipe_params)
  end

end
