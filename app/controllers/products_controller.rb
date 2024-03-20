class ProductsController < ApplicationController
  def index
    @products = Product.all

    if params[:query].present?
      @products = @products.where("product_name ILIKE ?", "%#{params[:query]}%")
    end

    respond_to do |format|
      format.html
      format.text { render partial: "products/products_list", locals: { products: @products }, formats: [:html] }
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = current_user.products.find(params[:id])
  end

  def update
    @product = current_user.products.find(params[:id])
    @product.update(product_params)
    redirect_to products_path
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :description)
  end
end
