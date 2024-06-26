class V1::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    @products = Product.includes(:supplier, :category).all
    render json: @products.to_json(include: { supplier: { exception: [:created_at, :updated_at ] }, category: {exception: [:created_at, :updated_at]}})
  end

  # GET /products/1
  def show
    render json: @product.to_json(include: { supplier: { exception: [:created_at, :updated_at ] }, category: {exception: [:created_at, :updated_at]}})
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:name, :description, :price, :quantity, :category_id, :measurement, :supplier_id, :code)
    end
end
