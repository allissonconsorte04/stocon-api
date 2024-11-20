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

  def find_by_bar_code
    @product = Product.find_by(bar_code: params[:bar_code])

    if @product
      render json: @product.to_json(include: {
        supplier: { except: [:created_at, :updated_at] },
        category: { except: [:created_at, :updated_at] },
      })
    else
      render json: { error: 'Produto não encontrado' }, status: :not_found
    end
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
